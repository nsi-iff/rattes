module Rattes
  module Curriculum
    module Utils
      def integerize(strnum)
        Integer(strnum)
      rescue ArgumentError
        nil
      end

      def booleanize(s)
        s == 'SIM'
      end
    end
  end
end
