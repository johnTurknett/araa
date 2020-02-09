require 'araa/table'

module Araa
  class ActiveRecord
    def self.filtered_application_tables
      # Removes the rails meta tables. Only returns application defined tables.
      ::ApplicationRecord.connection.tables.reject do |t|
        Araa::RAILS_META_TABLES.include?(t)
      end
    end

    def self.tables_field_map
      table_fields = []

      filtered_application_tables.each do |t|
        table = Araa::Table.new(t)
        table.fields.each do |field|
          table_fields << "#{t}::#{field}"
        end
      end

      table_fields
    end
  end
end
