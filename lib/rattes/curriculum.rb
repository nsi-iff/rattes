require 'nokogiri'

module Rattes
  class Curriculum
    def initialize(xml)
      @doc = Nokogiri::XML(xml)
    end

    def projects
      @doc.xpath('//PROJETO-DE-PESQUISA').map {|e| parse_project(e) }
    end

    private

    def parse_project(element)
      parent = element.parent
      Project.new(
        element['NOME-DO-PROJETO'],
        project_nature_constants(element['NATUREZA']),
        element['DESCRICAO-DO-PROJETO'],
        integerize(parent['ANO-INICIO']),
        department(parent),
        booleanize(element['FLAG-POTENCIAL-INOVACAO']),
        parse_sponsors(parent.xpath('.//FINANCIADOR-DO-PROJETO'))
      )
    end

    def parse_sponsors(elements)
      elements.map {|e| parse_sponsor(e) }
    end

    def parse_sponsor(element)
      Sponsor.new(
        element['NOME-INSTITUICAO'],
        sponsorship_nature_constants(element['NATUREZA'])
      )
    end

    Project = Struct.new(:name, :nature, :description, :start_year,
      :department, :innovation, :sponsors) do
      def innovation?
        innovation
      end
    end

    Sponsor = Struct.new(:institute, :nature)

    def sponsorship_nature_constants(value)
      @sponsorship_nature_constants ||= {
        'BOLSA' => 'Bolsa',
        'AUXILIO_FINANCEIRO' => 'Auxílio financeiro',
        'REMUNERACAO' => 'Remuneração',
        'OUTRO' => 'Outro',
        'COOPERACAO' => 'Cooperação',
        'NAO_INFORMADO' => 'Não informado'
      }
      @sponsorship_nature_constants[value]
    end

    def project_nature_constants(value)
      @project_nature_constants ||= {
        'DESENVOLVIMENTO' => 'Desenvolvimento',
        'EXTENSAO' => 'Extensão',
        'PESQUISA' => 'Pesquisa',
        'OUTRA' => 'Outra'
      }
      @project_nature_constants[value]
    end

    def integerize(strnum)
      Integer(strnum)
    rescue ArgumentError
      nil
    end

    def department(p)
      [p['NOME-ORGAO'], p['NOME-UNIDADE']].
        compact.
        map(&:strip).
        reject(&:empty?).
        join('/')
    end

    def booleanize(s)
      s == 'SIM'
    end
  end
end