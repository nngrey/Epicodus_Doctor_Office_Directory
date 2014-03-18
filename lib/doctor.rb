class Doctor

  attr_reader :name, :specialty_id

  def initialize(attributes)
    @name = attributes[:name]
    @specialty_id = attributes[:specialty_id]
  end

  def self.all
    list = []
    results = DB.exec("SELECT * FROM doctors;")
    results.each do |result|
      name = result['name']
      list << Doctor.new({:name => name, :specialty_id => 1})
    end
    list
  end

  def ==(another_doctor)
    self.name == another_doctor.name && self.specialty_id == another_doctor.specialty_id
  end

  def save
    DB.exec("INSERT INTO doctors (name) VALUES ('#{@name}');")
  end

end
