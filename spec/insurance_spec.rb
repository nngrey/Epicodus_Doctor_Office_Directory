require "spec_helper"

describe Insurance do
  it 'will be initialized with a name' do
    test_insurance = Insurance.new({:name => "Red Shield", :id => 1})
    test_insurance.name.should eq "Red Shield"
  end
end
