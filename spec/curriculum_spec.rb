require 'spec_helper'

describe Rattes::Curriculum do
  let(:curriculum) { Rattes::Curriculum.new(curriculum_xml) }

  it 'gets curriculum data' do
    expect(curriculum.name).to eq 'Linus Torvalds'
  end

  it "gets projects" do
    expect(curriculum.projects.count).to eq 2
    proj1, proj2 = curriculum.projects.sort_by(&:name)

    expect(proj1.name).to eq 'Sistemas de Suporte à Decisao'
    expect(proj1.nature).to eq 'Desenvolvimento'
    expect(proj1.description).to eq 'Projeto de pequeno porte...'
    expect(proj1.start_year).to eq 1999
    expect(proj1.institute).to eq 'Instituto Federal de Educação, Ciência e Tecnologia Fluminense'
    expect(proj1.department).to eq 'Coordenação de Informática/Desenvolvimento'
    expect(proj1.situation).to eq 'Em andamento'
    expect(proj1).to_not be_innovation
    expect(proj1).to be_in_progress
    expect(proj1.sponsors.count).to eq 1
    proj1fin1 = proj1.sponsors.first
    expect(proj1fin1.institute).to eq 'UNICEF'
    expect(proj1fin1.nature).to eq 'Cooperação'
    expect(proj1.members.count).to eq 2
    proj1member1, proj1member2 = proj1.members.sort_by(&:name)
    expect(proj1member1.name).to eq 'José da Silva'
    expect(proj1member2.name).to eq 'Linus Torvalds'


    expect(proj2.name).to eq 'Tratamento da Informação Não Estruturada'
    expect(proj2.nature).to eq 'Pesquisa'
    expect(proj2.description).to eq 'Projeto de pesquisa e desenvolvimento...'
    expect(proj2.start_year).to eq 2002
    expect(proj2.institute).to eq 'Instituto Federal de Educação, Ciência e Tecnologia Fluminense'
    expect(proj2.department).to eq 'Núcleo de Pesquisa em Sistemas de Informação'
    expect(proj2.situation).to eq 'Concluído'
    expect(proj2).to be_innovation
    expect(proj2).to_not be_in_progress
    expect(proj2.sponsors.count).to eq 2
    proj2fin1, proj2fin2 = proj2.sponsors.sort_by(&:institute)
    expect(proj2fin1.institute).to eq 'CNPq'
    expect(proj2fin1.nature).to eq 'Bolsa'
    expect(proj2fin2.institute).to eq 'IFF'
    expect(proj2fin2.nature).to eq 'Auxílio financeiro'
    expect(proj2.members.count).to eq 2
    proj2member1, proj2member2 = proj2.members.sort_by(&:name)
    expect(proj2member1.name).to eq 'José da Silva'
    expect(proj2member2.name).to eq 'Linus Torvalds'
  end

  it 'researcher is responsible to project?' do
    proj1, proj2 = curriculum.projects.sort_by(&:name)
    expect(proj1.name).to eq 'Sistemas de Suporte à Decisao'
    expect(proj1.researcher_is_responsible?).to be_falsy
    expect(proj2.name).to eq 'Tratamento da Informação Não Estruturada'
    expect(proj2.researcher_is_responsible?).to be_truthy
  end

  describe 'gets projects under responsability of the researcher' do
    it "all" do
      expect(curriculum.responsible_projects.count).to eq 1
      proj = curriculum.responsible_projects.first
      expect(proj.name).to eq 'Tratamento da Informação Não Estruturada'
    end
  end
end
