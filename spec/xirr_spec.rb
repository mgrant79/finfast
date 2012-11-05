require 'spec_helper'
require 'date'

describe Finfast do

  def dt(y, m, d)
    Date.civil(y, m, d)
  end

  before :each do
    @trans = Hash.new
  end
    

  it "should calculate scenario 1 correctly" do
    # 1/1/2012	-100
    # 1/4/2012	1
    # 2/3/2012	1
    # 4/5/2012	1
    # 6/7/2012	1
    # 1/1/2013	100
    # ANSWER	0.041206977068671
    
    @trans[dt(2012, 1, 1)] = -100
    @trans[dt(2012, 1, 4)] = 1 
    @trans[dt(2012, 2, 3)] = 1
    @trans[dt(2012, 4, 5)] = 1
    @trans[dt(2012, 6, 7)] = 1
    @trans[dt(2013, 1, 1)] = 100

    Finfast.xirr(@trans).should be_near(0.041206977068671)

  end

  it "should calculate scenario 2 correctly" do
    # 3/9/2007	-1530.95
    # 10/23/2012	209.3
    
    # xirr	-0.297726819710638

    @trans[dt(2007, 3, 9)] = -1530.95
    @trans[dt(2012,10,23)] = 209.3
    Finfast.xirr(@trans).should be_near(-0.297726819710638)
  end

  

end
