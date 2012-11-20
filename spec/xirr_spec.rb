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

  it "should calculate scenario 3 correctly" do
    # Trade Date	Net Money
    # 9/22/2010	-825.0003
    # 12/10/2010	-0.1299
    # 12/10/2010	-32.0495
    # 12/10/2010	-0.5996
    # 12/21/2010	-9.5396
    # 5/23/2011	-562.2407
    # 12/19/2011	-12.8494
    # 12/19/2011	-74.74
    # 12/21/2011	-3.0405
    # 11/16/2012	1740.6629
    
    # 	0.076704239587883

    @trans[dt(2010, 9, 22)] = -825.0003
    @trans[dt(2010, 12, 10)] = -0.1299
    @trans[dt(2010, 12, 10)] += -32.0495
    @trans[dt(2010, 12, 10)] += -0.5996
    @trans[dt(2010, 12, 21)] = -9.5396
    @trans[dt(2011, 5, 23)] = -562.2407
    @trans[dt(2011, 12, 19)] = -12.8494
    @trans[dt(2011, 12, 19)] += -74.74
    @trans[dt(2011, 12, 21)] = -3.0405
    @trans[dt(2012, 11, 16)] = 1740.6629
    
    Finfast.xirr(@trans).should be_near(0.076704239587883)
  end

end
