require 'spec_helper'

describe Finfast do

  it "should calculate IPMT" do
    Finfast.ipmt(0.7, 1, 10, 1000).should be_near 700.0
    Finfast.ipmt(0.7, 2, 10, 1000).should be_near 697.55732058861
  end

  it "should calculate IPMTs (interest payment stream)" do
    stream = Finfast.ipmts(0.7, (1..2), 10, 1000)
    stream[0].should be_near 700.0
    stream[1].should be_near 697.55732058861
  end

end
