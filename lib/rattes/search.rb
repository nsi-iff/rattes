require 'yaml'

module Rattes
  class Search
    def initialize(driver)
      @driver = driver
    end

    def search(options)
      options = options.clone
      replace_keys(options)
      @driver.search(options)
    end

    private

    def replace_keys(options)
      options.keys.each do |k|
        field_name = k.to_s
        if fields[field_name]
          value = options.delete(k)
          options[fields[field_name]['name'].to_s] = value
        end
      end
    end

    def fields
      path = File.expand_path(File.join(
        File.dirname(__FILE__), '..', '..', 'config', 'fields.yml'))
      @fields ||= YAML.load_file(path)
    end
  end
end
