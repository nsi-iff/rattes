require 'nokogiri'
require 'methodize'

module Rattes
  class Parser
    class << self
      def parse(xml_file)
        doc = Nokogiri::XML(xml_file, nil, 'UTF-8')
        curriculum = doc.children.first
        result = parse_element(curriculum)
        result.extend(Methodize)
        methodize_arrays(result)
        result
      end

      private

      def methodize_arrays(hash)
        hash.each do |key, value|
          methodize_arrays(value) if value.is_a? Hash
          if value.is_a? Array
            value.
              select {|e| e.is_a? Hash }.
              each do |sub_hash|
                sub_hash.extend(Methodize)
                methodize_arrays(sub_hash)
              end
          end
        end
      end

      def parse_element(element, hash = {})
        collect_attributes(element, hash)
        element.elements.
          select(&nokogiri_element?).
          each do |sub_element|
            name = normalize(sub_element.name)
            if hash[name].nil?
              sub_hash = hash[name] = {}
            else
              hash[name] = [hash[name]] unless hash[name].is_a? Array
              sub_hash  = {}
              hash[name] << sub_hash
            end
            parse_element(sub_element, sub_hash)
          end
        hash
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
