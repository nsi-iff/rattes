module Rattes
  module Curriculum
    class Curriculum
      def initialize(xml)
        @doc = Nokogiri::XML(xml)
      end

      def projects
        @doc.xpath('//PROJETO-DE-PESQUISA').map {|e| Project.new(e) }
      end
    end
  end
end
