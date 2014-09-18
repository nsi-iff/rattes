module Rattes
  module Curriculum
    class Project
      include Utils

      def initialize(curriculum, doc)
        @curriculum = curriculum
        @doc = doc
        parse!
      end

      attr_reader :name, :nature, :description, :start_year, :department,
        :sponsors

      def innovation?
        @innovation
      end

      def researcher_is_responsible?
        responsible = @doc.xpath(
          ".//INTEGRANTES-DO-PROJETO[@FLAG-RESPONSAVEL='SIM']").first
        responsible['NOME-COMPLETO'] == @curriculum.name
      end

      private

      def parse!
        parent = @doc.parent
        @name = @doc['NOME-DO-PROJETO']
        @nature = nature_constants(@doc['NATUREZA'])
        @description = @doc['DESCRICAO-DO-PROJETO']
        @start_year = integerize(parent['ANO-INICIO'])
        @department = parse_department(parent)
        @innovation = booleanize(@doc['FLAG-POTENCIAL-INOVACAO'])
        @sponsors = get_sponsors(parent)
      end

      def nature_constants(key)
        @nature_constants ||= {
          'DESENVOLVIMENTO' => 'Desenvolvimento',
          'EXTENSAO' => 'Extensão',
          'PESQUISA' => 'Pesquisa',
          'OUTRA' => 'Outra'
        }
        @nature_constants[key]
      end

      def parse_department(d)
        [d['NOME-ORGAO'], d['NOME-UNIDADE']].
          compact.
          map(&:strip).
          reject(&:empty?).
          join('/')
      end

      def get_sponsors(doc)
        doc.xpath('.//FINANCIADOR-DO-PROJETO').map {|e| Sponsor.new(e) }
      end
    end
  end
end
