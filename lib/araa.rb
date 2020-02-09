require "araa/railtie"

module Araa
  # Todo: Is this defined anywhere in ActiveRecord?
  RAILS_META_TABLES = %w(schema_migrations ar_internal_metadata).freeze
  RAILS_META_COLUMNS = %w(id created_at updated_at).freeze
end
