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

  private

  def self.exp(d_i, d_0)
    if (d_i).is_a?(Date)
      ((d_i - d_0).to_i / DAYS_PER_YEAR)
    else
      raise "Can't calculate exponents for #{d_i.class}"
    end
  end

  module_function :xirr, :newton

end
