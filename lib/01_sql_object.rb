require_relative 'db_connection'
require_relative '02_searchable'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject

  def self.columns
    @columns ||= DBConnection.execute2(<<-SQL).first.map{|string| string.to_sym}
      SELECT
      *
      FROM
      #{table_name}
    SQL
    @columns
  end

  def self.finalize!
    columns.each do |column|
      define_method "#{column}=" do |val|
        attributes[column]= val
      end
      define_method "#{column}" do
        attributes[column]
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.to_s.tableize
  end

  def self.all
    self.inspect
  end

  def self.parse_all(results)
    results.map do |result|
      self.new(result)
    end
  end

  def self.find(id)
    parse_all(DBConnection.execute(<<-SQL, id)).first
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        id = ?
    SQL
  end

  def initialize(params = {})
     params.each do |key, value|
       attr_name = key.to_sym
       raise "unknown attribute '#{attr_name}'" unless self.class.columns.include? attr_name
       self.attributes[attr_name] = value
     end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.class.columns.map do |column|
      send(column)
    end
  end

  def insert
    columns =  self.class.columns
    col_names = columns.join(", ")
    question_marks = ["? "] * columns.size
    DBConnection.execute(<<-SQL, attribute_values)
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{question_marks.join(', ')})
    SQL
    self.id = DBConnection.last_insert_row_id
  end

  def update
    col_names = self.class.columns.map{|attr_name| "#{attr_name} = ?"}.join(", ")
    DBConnection.execute(<<-SQL, attribute_values, id)
      UPDATE
        #{self.class.table_name}
      SET
        #{col_names}
      WHERE
        id = ?
    SQL
  end

  def save
    if id.nil?
      insert
    else
      update
    end
  end

  def self.inspect
    @select_string ||= "*"
    @where_string ||= ''
    @join_string ||= ""

    sql_string = "Select #{@select_string} FROM #{self.table_name} "
    sql_string += "JOIN #{@join_string} " unless @join_string.empty?
    sql_string += "WHERE #{@where_string}" unless @where_string.empty?
    p sql_string
    results = parse_all(DBConnection.execute(sql_string, @params_values))
    reset_variables
    results
  end

  def self.reset_variables
    @where_string = ''
    @select_string = "*"
    @params_values =  []
    @join_string = ""
  end

  def self.includes(name)

  end

  def self.joins(name)
    @join_string ||= ""
    raise "unkown method #{name}" unless methods.include?(name)
    @join_string += "#{assoc_options[name].table_name} ON #{self.to_s}.id = #{assoc_options[name].table_name}.#{assoc_options[name].foreign_key}"
    self
  end
end

class Cat < SQLObject
  belongs_to :human
end

class Human< SQLObject
end
Human.table_name = 'humans'
p Cat.joins(:human).where(name: "Breakfast")
