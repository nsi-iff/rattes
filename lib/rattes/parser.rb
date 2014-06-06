require 'nokogiri'
require 'methodize'

module Rattes
  class Parser
    class << self
      def parse(xml_file)
        doc = Nokogiri::XML(xml_file)
        curriculum = doc.children.first
        result = parse_children(curriculum)
        result.extend(Methodize)
        result
      end

      private

      def parse_children(source, origin = {})
        iterate_children(source, origin) do |element|
          this_element = origin
          element.each do |attr_name, attr_value|
            key = normalize(attr_name)
            this_element[key] = attr_value
          end
          parse_children(element, this_element)
          this_element
        end
      end


      def iterate_children(container, origin)
        result = origin
        container.children.
          select {|c| c.is_a? Nokogiri::XML::Element }.
          each do |element|
            key = normalize(element.name)
            result[key] = yield element, element.children
          end
        result
      end

      def normalize(name)
        name.gsub('-', '_').downcase
      end
    end
  end
end
