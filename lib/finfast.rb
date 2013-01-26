require 'finfast/version'
require 'finfast/finfast'

module Finfast
  
  DAYS_PER_YEAR = 365.0

  # Calculates internal rate of return on a series of irregular cash flows, similar
  # to the OpenOffice.org XIRR function described here:
  # http://wiki.openoffice.org/wiki/Documentation/How_Tos/Calc%3a_XIRR_function
  #
  # Params:
  # +transactions+:: A hash of {date: d, pmt: p}
  # +guess+:: An initial guess for the algorithm.
  #
  def xirr(transactions, guess=0.0, tolerance=1e-6, iterations=100)
    date_array = transactions.keys
    pmt_array = transactions.values
    d_0 = date_array.min
    exp_array = date_array.map { |d| exp(d, d_0) }
    newton(pmt_array, exp_array, guess, tolerance, iterations)
  end

  # Future value of an annuity.
  #
  # Params:
  # +i+:: The interest rate per period
  # +n+:: The number of periods
  # +pmt+:: The payment made in each period
  # 
  def fvan(i, n, pmt)
    return pmt * (((1 + i) ** n) - 1) / i 
  end

  # Future value of a lump amount.
  #
  # Params:
  # +i+:: The interest rate per period
  # +n+:: The number of periods
  # +amt+:: The amount in today's terms (present value)
  # 
  def fv(i, n, amt)
    return  ((1 + i) ** n) * amt
  end

  # Calculates the payment for a loan based on constant payments and a
  # constant interest rate.
  #
  # Params:
  # +i+:: The interest rate per period
  # +n+:: The number of periods
  # +pv+:: The present value, or principal
  #
  def pmt(i, n, pv)
    return pv  /  ((1 - (1 / (1 + i) ** n )) / i)
  end

  # The interest payment for a given period in an investment.
  #
  # Params:
  # +i+:: The interest rate per period
  # +n+:: The number of periods
  # +per+:: The period for which to calculate the interest payment
  # +pv+:: The present value, or principal
  #
  def ipmt(i, per, n, pv)
    pmt = pmt(i, n, pv)
    return ipmtp(i, per, pv, pmt)
  end

  # The interest payment for a loan, given that you are making a fixed
  # payment different from the one dictated by the terms of the loan.
  #
  # Params:
  # +i+:: The interest rate per period
  # +per+:: The period for which to calculate the interest payment
  # +pv+:: The present value, or principal
  # +pmt+:: The amount of the fixed payment
  #
  def ipmtp(i, per, pv, pmt)
    fv_orig = fv(i, per - 1, pv)       # FV at the beginning of the period
    fvan_pmts = fvan(i, per - 1, pmt)  # FV of what we've been paying
    balance_in_period = fv_orig - fvan_pmts # FV of what's left
    return balance_in_period * i
  end

  def ipmts(i, pers, n, pv)
    result = []
    pers.each do |p|
      result.push(ipmt(i, p, n, pv))
    end
    return result
  end

  def ipmtsp(i, pers, pv, pmt)
    result = []
    pers.each do |p|
      result.push(ipmtp(i, p, pv, pmt))
    end
    return result
  end

  def pv_stream(i, stream)
    result = 0
    stream.each_with_index do |x, p|
      result += x / (1 + i) ** (p + 1)
    end
    return result
  end

  def date_difference_months(d1, d2)
    return d1.year * 12 - d2.year * 12 + d1.month - d2.month
  end

  private

  def self.exp(d_i, d_0)
    if (d_i).is_a?(Date)
      ((d_i - d_0).to_i / DAYS_PER_YEAR)
    else
      raise "Can't calculate exponents for #{d_i.class}"
    end
  end

  module_function :xirr, :pmt, :ipmt, :ipmtp, :ipmts, :fv, :fvan, :newton

end
