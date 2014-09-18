require 'nokogiri'

module Rattes
  module Curriculum
    autoload :Curriculum, 'rattes/curriculum/curriculum'
    autoload :Project, 'rattes/curriculum/project'
    autoload :Sponsor, 'rattes/curriculum/sponsor'
    autoload :Utils, 'rattes/curriculum/utils'

    def self.new(*params)
      Curriculum.new(*params)
    end
  end
end
