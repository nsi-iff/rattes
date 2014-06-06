require 'spec_helper'
require 'date'

describe Rattes::Parser do
  describe 'general data extraction' do
    let(:dados_gerais) do
      Rattes::Parser.parse(curriculum_xml).dados_gerais
    end

    it 'extracts personal data' do
      expect(dados_gerais.nome_completo).to eql 'Linus Torvalds'
      expect(dados_gerais.nome_em_citacoes_bibliograficas).to eql 'TORVALDS, L.'
      expect(dados_gerais.nacionalidade).to eql "B"
      expect(dados_gerais.cpf).to eql "12345678909"
      expect(dados_gerais.pais_de_nascimento).to eql "Brasil"
      expect(dados_gerais.uf_nascimento).to eql "RJ"
      expect(dados_gerais.cidade_nascimento).to eql "Campos dos Goytacazes"
      expect(dados_gerais.data_nascimento).to eql "04021973"
      expect(dados_gerais.sexo).to eql "MASCULINO"
      expect(dados_gerais.numero_identidade).to eql "123456789"
      expect(dados_gerais.orgao_emissor).to eql "IFP"
      expect(dados_gerais.uf_orgao_emissor).to eql "RJ"
      expect(dados_gerais.data_de_emissao).to eql "05061991"
      expect(dados_gerais.numero_de_passaporte).to eql nil
      expect(dados_gerais.nome_do_pai).to eql "Linus Torvalds Senior"
      expect(dados_gerais.nome_da_mae).to eql "Lina Torvalds"
      expect(dados_gerais.permissao_de_divulgacao).to eql "NAO"
      expect(dados_gerais.data_falecimento).to eql ''
      expect(dados_gerais.raca_ou_cor).to eql "Parda"
      expect(dados_gerais.sigla_pais_nacionalidade).to eql "BRA"
      expect(dados_gerais.pais_de_nacionalidade).to eql "Brasil"
    end

    it 'extracts summary' do
      resumo_cv = dados_gerais.resumo_cv
      expect(resumo_cv.texto_resumo_cv_rh).to eql 'possui diversos cursos mundo afora.'
      expect(resumo_cv.texto_resumo_cv_rh_en).to eql ''
    end

    it 'extracts other relevant information' do
      outras = dados_gerais.outras_informacoes_relevantes
      expect(outras.outras_informacoes_relevantes).to eql ''
    end
  end
end
