module Rattes
  module Curriculum
    class Member
      def initialize(doc)
        @doc = doc
        parse!
      end

      attr_reader :name

      private

      def parse!
        @name = @doc['NOME-COMPLETO']
      end
    end
  end
end
