require 'araa/active_record'
require 'fileutils'

namespace :araa do
  desc 'Creates the Araa config file if it does not exist.'
  task create_models_config: :environment do
    path = File.join(Rails.root, 'config', 'initializers', 'araa_models.rb')
    FileUtils.touch path
  end

  desc "Generates the associations and stores them in an initializer"
  task generate: [:environment, :create_models_config] do
    path = File.join(Rails.root, 'config', 'initializers', 'araa_models.rb')
    tables_and_fields = Araa::ActiveRecord.tables_field_map

    tables = Araa::ActiveRecord.filtered_application_tables.map do |t|
      table = Araa::Table.new(t)
      table.find_belongs_to
      table.find_has_many(tables_and_fields)
      table.find_has_many_through(tables_and_fields)
      table
    end

    File.open(path, 'w') do |f|
      tables.each do |table|
        next unless table.has_relations?
        f.write "class #{table.model_name} < ApplicationRecord\n"

        table.belongs_to.each { |bt| f.write "\tbelongs_to :#{bt}\n" }
        table.has_many.each { |bt| f.write "\thas_many :#{bt}\n" }
        table.has_many_through.each { |hmt|
          f.write "\thas_many :#{hmt[0]}, through: :#{hmt[1]}\n"
        }

        f.write "end\n\n"
      end
    end
  end
end
