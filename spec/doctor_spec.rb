require 'spec_helper'

describe Doctor do
  it 'will be initialized with name and a specialty' do
  test_doctor = Doctor.new({:name => 'John Smith', :specialty_id => 1})
  test_doctor.should be_an_instance_of Doctor
  test_doctor.name.should eq 'John Smith'
  end

  describe '.save' do
    it 'should save the object to the database' do
      test_doctor = Doctor.new({:name => 'John Smith', :specialty_id => 1})
      test_doctor.save
      Doctor.all.should eq [test_doctor]
    end
  end
end
