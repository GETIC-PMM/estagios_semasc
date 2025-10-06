require 'rails_helper'

RSpec.describe "indicacoes/new", type: :view do
  before(:each) do
    assign(:indicacao, Indicacao.new(
      solicitacao: nil,
      estagiario: nil,
      situacao: "MyString",
      observacao: "MyText"
    ))
  end

  it "renders new indicacao form" do
    render

    assert_select "form[action=?][method=?]", indicacoes_path, "post" do

      assert_select "input[name=?]", "indicacao[solicitacao_id]"

      assert_select "input[name=?]", "indicacao[estagiario_id]"

      assert_select "input[name=?]", "indicacao[situacao]"

      assert_select "textarea[name=?]", "indicacao[observacao]"
    end
  end
end
