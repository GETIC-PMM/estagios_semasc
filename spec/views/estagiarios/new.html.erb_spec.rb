require 'rails_helper'

RSpec.describe "estagiarios/new", type: :view do
  before(:each) do
    assign(:estagiario, Estagiario.new(
      nome_completo: "MyString",
      email: "MyString",
      cpf: "MyString",
      telefone: "MyString",
      universidade: nil,
      curso: nil,
      turno: "MyString",
      ano_ingresso: "MyString",
      ira: "9.99",
      horarios_disponiveis: "MyString",
      possui_graduacao_anterior: false,
      possui_deficiencia: false,
      anexo_documento: "MyString",
      anexo_comprovante_matricula: "MyString",
      anexo_curriculo: "MyString"
    ))
  end

  it "renders new estagiario form" do
    render

    assert_select "form[action=?][method=?]", admin_estagiarios_path, "post" do

      assert_select "input[name=?]", "estagiario[nome_completo]"

      assert_select "input[name=?]", "estagiario[email]"

      assert_select "input[name=?]", "estagiario[cpf]"

      assert_select "input[name=?]", "estagiario[telefone]"

      assert_select "input[name=?]", "estagiario[universidade_id]"

      assert_select "input[name=?]", "estagiario[curso_id]"

      assert_select "input[name=?]", "estagiario[turno]"

      assert_select "input[name=?]", "estagiario[ano_ingresso]"

      assert_select "input[name=?]", "estagiario[ira]"

      assert_select "input[name=?]", "estagiario[horarios_disponiveis]"

      assert_select "input[name=?]", "estagiario[possui_graduacao_anterior]"

      assert_select "input[name=?]", "estagiario[possui_deficiencia]"

      assert_select "input[name=?]", "estagiario[anexo_documento]"

      assert_select "input[name=?]", "estagiario[anexo_comprovante_matricula]"

      assert_select "input[name=?]", "estagiario[anexo_curriculo]"
    end
  end
end
