require './lib/doctor'
require './lib/specialty'
require './lib/patient'
require './lib/insurance'
require 'pg'

DB = PG.connect({:dbname => 'doctor_office'})

def main_menu
  puts "\nDoctor's Office"
  puts "---------------"
  puts "Press 'd' to add a doctor"
  puts "Press 'p' to add a patient"
  puts "Press 'i' to add an insurance company"
  puts "Press 'o' to see a list of doctors by specialty"
  puts "Press 'a' to see a list of patients by doctor"
  puts "Press 'x' to exit"
  user_input = gets.chomp

  case user_input
    when 'd'
      add_doctor
    when 'p'
      add_patient
    when 'i'
      add_insurance
    when 'o'
      list_docs
    when 'a'
      list_patients
    when 'x'
      puts "Goodbye"
    end
end

def add_doctor
  puts "Enter the name of your doctor"
  doctor_name = gets.chomp
  Specialty.all.each_with_index do |spec, index|
    puts "#{index + 1}) #{spec.name}"
  end
  puts "\nEnter your doctors specialty"
  dr_specialty = gets.chomp
  Insurance.all.each_with_index do |ins, index|
    puts "#{index + 1}) #{ins.name}"
  end
  puts "\nWhich insurance does the doctor accept?"
  dr_ins = gets.chomp
  new_doctor = Doctor.new({:name => doctor_name, :specialty_id => Specialty.all[dr_specialty.to_i - 1].id.to_i, :insurance_id => Insurance.all[dr_ins.to_i - 1].id.to_i})
  new_doctor.save
  puts "You have added #{new_doctor.name}, a specialist in #{Specialty.all[dr_specialty.to_i - 1].name}"
  puts "This doctor only takes the following insurance: #{Insurance.all[dr_ins.to_i - 1].name}"
  main_menu
end

def add_patient
  Doctor.all.each do |doctor|
    puts "Dr. ID: #{doctor.id} #{doctor.name}"
  end
  puts "Enter the ID of the patient's doctor"
  dr_id = gets.chomp
  puts "Enter the name of the patient"
  patient_name = gets.chomp
  puts "Enter the patient's birthday in the form YYYY-MM-DD"
  patient_birthday = gets.chomp
  new_patient = Patient.new({:name => patient_name, :birthday => patient_birthday, :dr_id => dr_id})
  new_patient.save
  puts "You have added #{new_patient.name}"
  main_menu
end

def add_insurance
  puts "Enter the name of the insurance company"
  ins_co = gets.chomp
  new_co = Insurance.new({:name => ins_co})
  new_co.save
  puts "You added #{new_co.name}"
  main_menu
end

def list_docs
  Specialty.all.each_with_index do |spec, index|
    puts "#{index + 1}) #{spec.name}"
  end
  puts "\nEnter a specialty to see a list of doctors"
  specialty_num = gets.chomp
  puts "\nThe following doctors specialize in #{Specialty.all[specialty_num.to_i - 1].name}:"
  puts "-------------------------------------------------"
  Doctor.all.each do |doctor|
    if doctor.specialty_id == Specialty.all[specialty_num.to_i - 1].id.to_i
      puts doctor.name
    end
  end
  main_menu
end

def list_patients
  Doctor.all.each do |doctor|
    puts "Dr. ID: #{doctor.id} #{doctor.name}"
  end
  puts "Enter a doctor's id to see a list of his/her patients"
  doc_id = gets.chomp.to_i
  doc_search = Doctor.search(doc_id)
  puts "\nHere are the patients for Dr. #{doc_search.first.name}:"
  puts "-------------------------------------"
  Patient.all.each do |patient|
    if patient.dr_id == doc_search.first.id
      puts patient.name
    end
  end
  main_menu
end


main_menu
