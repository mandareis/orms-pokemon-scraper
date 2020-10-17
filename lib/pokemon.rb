require "pry"

class Pokemon
  attr_accessor :id, :name, :type, :db

  def self.save(name, type, db)
    sql = <<-SQL
    INSERT INTO pokemon(name, type)
    VALUES (?,?)
    SQL
    db.execute(sql, name, type)
  end
  def self.find(id, db)
    sql = <<-SQL
    SELECT * FROM pokemon
    WHERE id = ?
    SQL
    fresh_from_db = db.execute(sql, id)
    now_special_pokemon_instance = fresh_from_db.map do |row|
      Pokemon.new(id: row[0], name: row[1], type: row[2], db: db)
    end
    now_special_pokemon_instance.first
  end

  def initialize(id:, name:, type:, db:)
    @id = id
    @name = name
    @type = type
    @db = db
  end
end
