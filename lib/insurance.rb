class Insurance

  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
  end

  def self.all
    list = []
    results = DB.exec("SELECT * FROM insurance;")
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      list << Insurance.new({:name => name, :id => id})
    end
    list
  end

  def save
    results = DB.exec("INSERT INTO insurance (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

end
