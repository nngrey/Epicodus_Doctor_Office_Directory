class Patient

  attr_reader :name, :dr_id, :birthday

  def initialize(attributes)
    @name = attributes[:name]
    @dr_id = attributes[:dr_id]
    @birthday = attributes[:birthday]
  end

  def self.all
    list = []
    results = DB.exec("SELECT * FROM patients;")
    results.each do |result|
      name = result['name']
      dr_id = result['dr_id'].to_i
      birthday = result['birthday']
      list << Patient.new({:name => name, :dr_id => dr_id, :birthday => birthday})
    end
    list
  end

  def ==(another_patient)
    self.name == another_patient.name && self.dr_id == another_patient.dr_id
  end

  def save
    DB.exec("INSERT INTO patients (name, dr_id, birthday) VALUES ('#{@name}', '#{@dr_id.to_i}', '#{@birthday}');")
  end

end
