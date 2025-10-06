require 'rails_helper'

RSpec.describe "estagiarios/index", type: :view do
  before(:each) do
    assign(:estagiarios, [
      Estagiario.create!(
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
      ),
      Estagiario.create!(
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
      )
    ])
  end

  it "renders a list of estagiarios" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Nome Completo".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Email".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Cpf".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Telefone".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Turno".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Ano Ingresso".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("9.99".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Horarios Disponiveis".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(false.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(false.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Anexo Documento".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Anexo Comprovante Matricula".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Anexo Curriculo".to_s), count: 2
  end
end
