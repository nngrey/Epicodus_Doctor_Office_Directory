require "spec_helper"

describe Specialty do
  it 'will be initialized with a name' do
    test_specialty = Specialty.new({:name => "Podiatry", :id => 1})
    test_specialty.name.should eq "Podiatry"
  end
end
