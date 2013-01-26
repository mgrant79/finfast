require 'spec_helper'

describe Finfast do

  before :each do
    @trans = Hash.new
  end
    

  it "should calculate XIRR scenario 1 correctly" do
    @trans[dt(2012, 1, 1)] = -100
    @trans[dt(2012, 1, 4)] = 1 
    @trans[dt(2012, 2, 3)] = 1
    @trans[dt(2012, 4, 5)] = 1
    @trans[dt(2012, 6, 7)] = 1
    @trans[dt(2013, 1, 1)] = 100
    Finfast.xirr(@trans).should be_near(0.041206977068671)
  end

  it "should calculate XIRR scenario 2 correctly" do
    @trans[dt(2007, 3, 9)] = -1530.95
    @trans[dt(2012,10,23)] = 209.3
    Finfast.xirr(@trans).should be_near(-0.297726819710638)
  end

  it "should calculate XIRR scenario 3 correctly" do
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

  it "should calculate XIRR scenario 4 correctly" do
    @trans[dt(2010, 9, 22)] = -825.0003
    @trans[dt(2010, 12, 10)] = 32.77
    @trans[dt(2010, 12, 10)] += -0.1299
    @trans[dt(2010, 12, 10)] += -32.0495
    @trans[dt(2010, 12, 10)] += -0.5996
    @trans[dt(2010, 12, 21)] = 9.56
    @trans[dt(2010, 12, 21)] += -9.5396
    @trans[dt(2011, 5, 23)] = -562.2407
    @trans[dt(2011, 12, 19)] = 87.61
    @trans[dt(2011, 12, 19)] += -12.8494
    @trans[dt(2011, 12, 19)] += -74.74
    @trans[dt(2011, 12, 21)] = 2.99
    @trans[dt(2011, 12, 21)] += -3.0405
    @trans[dt(2012, 11, 16)] = 1740.6629
    Finfast.xirr(@trans).should be_near (0.127580828164465)
  end

end
