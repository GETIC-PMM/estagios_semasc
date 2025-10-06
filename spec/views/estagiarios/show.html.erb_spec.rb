require 'rails_helper'

RSpec.describe "estagiarios/show", type: :view do
  before(:each) do
    assign(:estagiario, Estagiario.create!(
      nome_completo: "Nome Completo",
      email: "Email",
      cpf: "Cpf",
      telefone: "Telefone",
      universidade: nil,
      curso: nil,
      turno: "Turno",
      ano_ingresso: "Ano Ingresso",
      ira: "9.99",
      horarios_disponiveis: "Horarios Disponiveis",
      possui_graduacao_anterior: false,
      possui_deficiencia: false,
      anexo_documento: "Anexo Documento",
      anexo_comprovante_matricula: "Anexo Comprovante Matricula",
      anexo_curriculo: "Anexo Curriculo"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Nome Completo/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Cpf/)
    expect(rendered).to match(/Telefone/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Turno/)
    expect(rendered).to match(/Ano Ingresso/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Horarios Disponiveis/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Anexo Documento/)
    expect(rendered).to match(/Anexo Comprovante Matricula/)
    expect(rendered).to match(/Anexo Curriculo/)
  end
end
