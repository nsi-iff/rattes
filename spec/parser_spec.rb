require 'spec_helper'
require 'date'

describe Rattes::Parser do
  describe 'general data extraction' do
    let(:curriculum) { Rattes::Parser.parse(curriculum_xml) }
    let(:dados_gerais) { curriculum.dados_gerais }
    let(:producao_tecnica) { curriculum.producao_tecnica }

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

    describe 'repeated elements parsed as array' do
      it 'extracts academic information' do
        fat = dados_gerais.formacao_academica_titulacao
        expect(fat.especializacao.count).to eq 3

        esp1, esp2, esp3 = fat.especializacao
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

      it 'extracts software production' do
        software = producao_tecnica.software
        expect(software.size).to eq 2
        software1, software2 = software

        expect(software1.sequencia_producao).to eql '2'
        dbc = software1.dados_basicos_do_software
        expect(dbc.natureza).to eq "COMPUTACIONAL"
        expect(dbc.titulo_do_software).to eq "Postgrow"
        expect(dbc.ano).to eq "2005"
        expect(dbc.pais).to eq "Brasil"
        expect(dbc.idioma).to eq ""
        expect(dbc.meio_de_divulgacao).to eq "NAO_INFORMADO"
        expect(dbc.home_page_do_trabalho).to eq "http://quintodosinferno.org"
        expect(dbc.flag_relevancia).to eq "SIM"
        expect(dbc.doi).to eq ""
        expect(dbc.titulo_do_software_ingles).to eq ""
        expect(dbc.flag_divulgacao_cientifica).to eq "NAO"
        expect(dbc.flag_potencial_inovacao).to eq "NAO"

        ds = software1.detalhamento_do_software
        expect(ds.finalidade).to eq "Awesome tool"
        expect(ds.plataforma).to eq "Java, Multiplataforma"
        expect(ds.ambiente).to eq "Multiplataforma"
        expect(ds.disponibilidade).to eq "IRRESTRITA"
        expect(ds.instituicao_financiadora).to eq ""
        expect(ds.finalidade_ingles).to eq ""

        autor1, autor2, autor3 = software1.autores
        expect(autor1.nome_completo_do_autor).to eq "Topo Giggio"
        expect(autor1.nome_para_citacao).to eq "GIGGIO, T."
        expect(autor1.ordem_de_autoria).to eq "2"
        expect(autor1.nro_id_cnpq).to eq ""
        expect(autor2.nome_completo_do_autor).to eq "Jaspion Honda"
        expect(autor2.nome_para_citacao).to eq "HONDA, J."
        expect(autor2.ordem_de_autoria).to eq "3"
        expect(autor2.nro_id_cnpq).to eq ""
        expect(autor3.nome_completo_do_autor).to eq "Zezin La da Rua"
        expect(autor3.nome_para_citacao).to eq "LA DA RUA, Z."
        expect(autor3.ordem_de_autoria).to eq "1"
        expect(autor3.nro_id_cnpq).to eq "1234567890123456"

        pc = software1.palavras_chave
        expect(pc.palavra_chave_1).to eq "Software Factory"
        expect(pc.palavra_chave_2).to eq "Extreme Modeling"
        expect(pc.palavra_chave_3).to eq "Bureaucratic Process"
        expect(pc.palavra_chave_4).to eq "Taylorist Development"
        expect(pc.palavra_chave_5).to eq ""
        expect(pc.palavra_chave_6).to eq ""

        ac1 = software1.areas_do_conhecimento.area_do_conhecimento_1
        expect(ac1.nome_grande_area_do_conhecimento).to eq "CIENCIAS_EXATAS_E_DA_TERRA"
        expect(ac1.nome_da_area_do_conhecimento).to eq "Ciência da Computação"
        expect(ac1.nome_da_sub_area_do_conhecimento).to eq ""
        expect(ac1.nome_da_especialidade).to eq ""

        ac2 = software1.areas_do_conhecimento.area_do_conhecimento_2
        expect(ac2.nome_grande_area_do_conhecimento).to eq "CIENCIAS_EXATAS_E_DA_TERRA"
        expect(ac2.nome_da_area_do_conhecimento).to eq "Ciência da Computação"
        expect(ac2.nome_da_sub_area_do_conhecimento).to eq "Metodologia e Técnicas da Computação"
        expect(ac2.nome_da_especialidade).to eq "Banco de Dados"

        ia = software1.informacoes_adicionais
        expect(ia.descricao_informacoes_adicionais).to eq "Ferramenta para OLAP Espacial."
        expect(ia.descricao_informacoes_adicionais_ingles).to eq ""
      end
    end
  end
end
