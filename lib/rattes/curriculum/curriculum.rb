module Rattes
  module Curriculum
    class Curriculum
      def initialize(xml)
        @doc = Nokogiri::XML(xml)
        parse!
      end

      attr_reader :name

      def projects
        @doc.xpath('//PROJETO-DE-PESQUISA').map {|e| Project.new(self, e) }
      end

      def responsible_projects
        projects.select(&:researcher_is_responsible?)
      end

      private

      def parse!
        general_data = @doc.xpath('//DADOS-GERAIS').first
        @name = general_data['NOME-COMPLETO']
      end
    end
  end
end
