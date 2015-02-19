require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    class_name.constantize
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    @class_name = name.to_s.capitalize
    @foreign_key = "#{name}_id".to_sym
    @primary_key = :id

    options.each do |attr, value|
      instance_variable_set("@#{attr}", value)
    end
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    @class_name = name.to_s.singularize.capitalize
    @foreign_key = "#{self_class_name.downcase}_id".to_sym
    @primary_key = :id

    options.each do |attr, value|
      instance_variable_set("@#{attr}", value)
    end
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(assoc_name, user_options = {})
    options = BelongsToOptions.new(assoc_name, user_options)
    assoc_options[assoc_name] = options
    define_method "#{assoc_name}" do
      model_class = options.model_class
      model_class.where(:id => send(options.foreign_key)).first
    end

  end

  def has_many(assoc_name, user_options = {})
    options = HasManyOptions.new(assoc_name, self.to_s, user_options)
    assoc_options[assoc_name] = options
    define_method "#{assoc_name}" do
      model_class = options.model_class
      model_class.where(options.foreign_key => self.id)
    end
  end

  def assoc_options
    @options ||= {}
  end
end

class SQLObject
  extend Associatable
end
