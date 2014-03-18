require 'spec_helper'

describe Patient do
  it 'will initialize a new patient with a name, birthday, and doctor id' do
    test_patient = Patient.new({:name => "Jane Doe", :birthday => '1990-12-20', :doctor_id => 3})
    test_patient.name.should eq "Jane Doe"
    test_patient.birthday.should eq '1990-12-20'
  end

  describe '.save' do
    it 'will save the object to the database' do
      test_patient = Patient.new({:name => "Jane Doe", :birthday => "1990-12-20", :doctor_id => 4})
      test_patient.save
      Patient.all.should eq [test_patient]
    end
  end
end
