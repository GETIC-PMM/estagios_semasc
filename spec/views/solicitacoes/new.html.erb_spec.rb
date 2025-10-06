require 'rails_helper'

RSpec.describe "solicitacoes/new", type: :view do
  before(:each) do
    assign(:solicitacao, Solicitacao.new(
      secretaria: nil,
      curso: nil,
      perfil: "MyText",
      quantidade: 1,
      situacao: "MyString"
    ))
  end

  it "renders new solicitacao form" do
    render

    assert_select "form[action=?][method=?]", solicitacoes_path, "post" do

      assert_select "input[name=?]", "solicitacao[secretaria_id]"

      assert_select "input[name=?]", "solicitacao[curso_id]"

      assert_select "textarea[name=?]", "solicitacao[perfil]"

      assert_select "input[name=?]", "solicitacao[quantidade]"

      assert_select "input[name=?]", "solicitacao[situacao]"
    end
  end
end
