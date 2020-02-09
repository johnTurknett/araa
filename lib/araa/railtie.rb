module Araa
  class Railtie < ::Rails::Railtie
    rake_tasks do
      load 'tasks/araa_tasks.rake'
    end
  end
end
