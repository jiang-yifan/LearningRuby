require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    @where_string ||= ""
    @params_values ||= []
    unless @where_string.empty?
      @where_string.concat(" AND ").concat(params.keys.map{|key| "#{key} = ?"}.join(" AND "))
    else
      @where_string = params.keys.map{|key| "#{key} = ?"}.join(" AND ")
    end
    @params_values += params.values
    self
  end
end

class SQLObject
  extend Searchable
end
