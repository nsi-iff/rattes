module Rattes
  module Test
    module Resources
      def resource(name)
        File.open(File.expand_path(
          File.join(File.dirname(__FILE__), '..', 'resources', name)))
      end

      def curriculum_xml
        resource('curriculum.xml')
      end
    end
  end
end