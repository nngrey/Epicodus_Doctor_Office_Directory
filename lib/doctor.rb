class Doctor

  attr_reader :name, :specialty_id, :id

  def initialize(attributes)
    @name = attributes[:name]
    @specialty_id = attributes[:specialty_id]
    @id = attributes[:id]
  end

  def self.all
    list = []
    results = DB.exec("SELECT * FROM doctors;")
    results.each do |result|
      id = result['id'].to_i
      name = result['name']
      specialty_id = result['specialty_id'].to_i
      list << Doctor.new({:id => id, :name => name, :specialty_id => specialty_id})
    end
    list
  end

  def self.search(user_input)
    found = Doctor.all.find_all {|doctor| doctor.id.to_i == user_input}
  end

  # def search_by_id(check_id)
  #   check = []
  #   Doctor.all.each do |doctor|
  #     if doctor.id == check_id
  #       check << doctor
  #     end
  #   end
  #   check
  # end

  def ==(another_doctor)
    self.name == another_doctor.name && self.specialty_id == another_doctor.specialty_id
  end

  def save
    results = DB.exec("INSERT INTO doctors (name, specialty_id) VALUES ('#{@name}', '#{@specialty_id.to_i}') RETURNING id;")
    @id = results.first['id'].to_i
  end

end
