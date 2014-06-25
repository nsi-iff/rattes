require 'spec_helper'

describe Rattes::Curriculum do
  it 'performs search on fields loaded from yml' do
    driver = double
    real_field_name = 'producao_tecnica.software.autores.nome_completo_do_autor'
    expect(driver).to receive(:search).with(real_field_name => 'Linus')
    expect(driver).to receive(:search).with(real_field_name => ['Linus', :like])
    curriculum = Rattes::Curriculum.new(driver)
    curriculum.search(software_author: 'Linus')
    curriculum.search(software_author: ['Linus', :like])
  end
end