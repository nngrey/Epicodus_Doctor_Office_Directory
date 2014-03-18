class Specialty

  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
  end

  def self.all
    list = []
    results = DB.exec("SELECT * FROM specialty;")
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      list << Specialty.new({:name => name, :id => id})
    end
    list
  end

end
