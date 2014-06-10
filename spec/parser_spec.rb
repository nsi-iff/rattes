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
      expect(dados_gerais.numero_do_passaporte).to eql ''
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
      expect(resumo_cv.texto_resumo_cv_rh_en).to eql 'a lot of unuseful courses'
    end

    it 'extracts other relevant information' do
      outras = dados_gerais.outras_informacoes_relevantes
      expect(outras.outras_informacoes_relevantes).to eql 'alguma coisa'
    end

    it 'extracts repeated elements as array' do
      fat = dados_gerais.formacao_academica_titulacao
      expect(fat.especializacao.count).to eq 2

      esp1, esp2 = fat.especializacao
      expect(esp1.sequencia_formacao).to eq "4"
      expect(esp1.nivel).to eq "2"
      expect(esp1.titulo_da_monografia).to eq "Um Framework para Resolver um Problema que Acabei de Criar"
      expect(esp1.nome_do_orientador).to eq "Johnny Rotten"
      expect(esp1.codigo_instituicao).to eq "123412341234"
      expect(esp1.nome_instituicao).to eq "Instituto José das Couves"
      expect(esp1.codigo_curso).to eq "12341234"
      expect(esp1.nome_curso).to eq "Desenvolvimento de Software Orientado a Objetos"
      expect(esp1.status_do_curso).to eq "CONCLUIDO"
      expect(esp1.ano_de_inicio).to eq "2005"
      expect(esp1.ano_de_conclusao).to eq "2006"
      expect(esp1.flag_bolsa).to eq "SIM"
      expect(esp1.codigo_agencia_financiadora).to eq "09876543"
      expect(esp1.nome_agencia).to eq "FAPERJ"
      expect(esp1.carga_horaria).to eq "360"
      expect(esp1.titulo_da_monografia_ingles).to eq "An Awesome Unuseful Framework"
      expect(esp1.nome_curso_ingles).to eq "Object-Oriented Software Development"

      expect(esp2.sequencia_formacao).to eq "5"
      expect(esp2.nivel).to eq "2"
      expect(esp2.titulo_da_monografia).to eq "Um Sistema Bacana"
      expect(esp2.nome_do_orientador).to eq "Sistemeiro"
      expect(esp2.codigo_instituicao).to eq "123443211234"
      expect(esp2.nome_instituicao).to eq "Escola Superior José das Couves"
      expect(esp2.codigo_curso).to eq "9876543"
      expect(esp2.nome_curso).to eq "Engenharia de Programas"
      expect(esp2.status_do_curso).to eq "CONCLUIDO"
      expect(esp2.ano_de_inicio).to eq "2010"
      expect(esp2.ano_de_conclusao).to eq "2010"
      expect(esp2.flag_bolsa).to eq "NAO"
      expect(esp2.codigo_agencia_financiadora).to eq ""
      expect(esp2.nome_agencia).to eq ""
      expect(esp2.carga_horaria).to eq "480"
      expect(esp2.titulo_da_monografia_ingles).to eq "A Cool System"
      expect(esp2.nome_curso_ingles).to eq "Program Engineering"
    end
  end
end
