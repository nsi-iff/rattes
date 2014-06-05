require 'spec_helper'
require 'date'

describe Rattes::Parser do
  it 'extracts personal data' do
    result = Rattes::Parser.parse(curriculum_xml).dados_gerais
    expect(result.nome_completo).to eql 'Linus Torvalds'
    expect(result.nome_em_citacoes_bibliograficas).to eql 'TORVALDS, L.'
    expect(result.nacionalidade).to eql "B"
    expect(result.cpf).to eql "12345678909"
    expect(result.pais_de_nascimento).to eql "Brasil"
    expect(result.uf_nascimento).to eql "RJ"
    expect(result.cidade_nascimento).to eql "Campos dos Goytacazes"
    expect(result.data_nascimento).to eql "04021973"
    expect(result.sexo).to eql "MASCULINO"
    expect(result.numero_identidade).to eql "123456789"
    expect(result.orgao_emissor).to eql "IFP"
    expect(result.uf_orgao_emissor).to eql "RJ"
    expect(result.data_de_emissao).to eql "05061991"
    expect(result.numero_de_passaporte).to eql nil
    expect(result.nome_do_pai).to eql "Linus Torvalds Senior"
    expect(result.nome_da_mae).to eql "Lina Torvalds"
    expect(result.permissao_de_divulgacao).to eql "NAO"
    expect(result.data_falecimento).to eql ''
    expect(result.raca_ou_cor).to eql "Parda"
    expect(result.sigla_pais_nacionalidade).to eql "BRA"
    expect(result.pais_de_nacionalidade).to eql "Brasil"
  end
end
