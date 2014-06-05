require 'nokogiri'
require 'methodize'

module Rattes
  class Parser
    class << self
      def parse(xml_file)
        doc = Nokogiri::XML(xml_file)
        curriculum = doc.children.first
        result = {}
        iterate_children(curriculum) do |name, attributes|
          result[name] = this_element = {}
          attributes.each do |attr_name, attr_value|
            key = attr_name.gsub('-', '_').downcase
            this_element[key] = attr_value
          end
        end
        result.extend(Methodize)
        result
      end

      private

      def iterate_children(container)
        container.children.
          select {|c| c.is_a? Nokogiri::XML::Element }.
          each do |element|
            key = element.name.gsub('-', '_').downcase
            yield key, element
          end
      end
    end
  end
end
