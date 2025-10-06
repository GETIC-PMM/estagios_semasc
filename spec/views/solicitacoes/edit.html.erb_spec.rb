require 'rails_helper'

RSpec.describe "solicitacoes/edit", type: :view do
  let(:solicitacao) {
    Solicitacao.create!(
      secretaria: nil,
      curso: nil,
      perfil: "MyText",
      quantidade: 1,
      situacao: "MyString"
    )
  }

  before(:each) do
    assign(:solicitacao, solicitacao)
  end

  it "renders the edit solicitacao form" do
    render

    assert_select "form[action=?][method=?]", solicitacao_path(solicitacao), "post" do

      assert_select "input[name=?]", "solicitacao[secretaria_id]"

      assert_select "input[name=?]", "solicitacao[curso_id]"

      assert_select "textarea[name=?]", "solicitacao[perfil]"

      assert_select "input[name=?]", "solicitacao[quantidade]"

      assert_select "input[name=?]", "solicitacao[situacao]"
    end
  end
end
