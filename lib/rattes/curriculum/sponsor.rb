module Rattes
  module Curriculum
    class Sponsor
      def initialize(doc)
        @doc = doc
        parse!
      end

      attr_reader :institute, :nature

      private

      def parse!
        @institute = @doc['NOME-INSTITUICAO']
        @nature = nature_constants(@doc['NATUREZA'])
      end

      def nature_constants(key)
        @nature_constants ||= {
          'BOLSA' => 'Bolsa',
          'AUXILIO_FINANCEIRO' => 'Auxílio financeiro',
          'REMUNERACAO' => 'Remuneração',
          'OUTRO' => 'Outro',
          'COOPERACAO' => 'Cooperação',
          'NAO_INFORMADO' => 'Não informado'
        }
        @nature_constants[key]
      end
    end
  end
end
