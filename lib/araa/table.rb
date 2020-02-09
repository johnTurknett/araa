require 'araa/active_record'

module Araa
  class Table
    attr_accessor :belongs_to,
                  :has_many,
                  :has_many_through

    def initialize(name, build=false)
      @name = name
      @belongs_to = []
      @has_one = []
      @has_one_through = []
      @has_many = []
      @has_many_through = []
      @has_and_belongs_to_many = []

      if build
        find_belongs_to
        find_has_many
        find_has_many_through
      end
    end

    def table_name
      @name
    end

    def model_name
      table_name.singularize.camelize
    end

    def model
      model_name.constantize
    end

    def fields
      model.column_names.reject { |c| Araa::RAILS_META_COLUMNS.include?(c) }
    end

    def has_relations?
      @belongs_to.any? || @has_many.any? || @has_many_through.any?
    end

    def is_habtm?
      # a table is considered a has_and_belongs_to_many table if it only has
      # foreign key columns.
      fields.all? { |field| field.match(/_id$/) }
    end

    def find_belongs_to
      fields.each { |field|
        next unless field.match(/_id$/)
        @belongs_to << field.gsub('_id', '')
      }
    end

    def find_has_many(taf=Araa::ActiveRecord.tables_field_map)
      taf.each do |table_field|
        if Regexp.new("#{table_name.singularize}_id").match(table_field)
          @has_many << table_field.split('::').first
        end
      end
    end

    def find_has_many_through(taf=Araa::ActiveRecord.tables_field_map)
      @has_many.each do |hm|
        associated_table = Araa::Table.new(hm)
        associated_table.find_belongs_to

        associated_table.belongs_to.each do |bt|
          next if bt == table_name.singularize
          @has_many_through << [bt.pluralize, hm]
        end
      end
    end
  end
end
