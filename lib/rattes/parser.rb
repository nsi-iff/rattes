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
        collect_attributes(source, origin)
        elements = source.elements.select(&nokogiri_element?)
        result = origin
        elements.each do |element|
          name = normalize(element.name)
          element_hash = result[name] = {}
          collect_attributes(element, element_hash)
          element.elements.select(&nokogiri_element?).each do |sub_element|
            name = normalize(sub_element.name)
            sub_element_hash = element_hash[name] = {}
            parse_children(sub_element, sub_element_hash)
          end
        end
        result
      end

      def collect_attributes(source, origin)
        source.each do |(attr_name, attr_value)|
          attr_name = normalize(attr_name)
          origin[attr_name] = attr_value
        end
      end

      def nokogiri_element?
        lambda {|c| c.is_a? Nokogiri::XML::Element }
      end

      def normalize(name)
        name.gsub('-', '_').downcase
      end
    end
  end
end
