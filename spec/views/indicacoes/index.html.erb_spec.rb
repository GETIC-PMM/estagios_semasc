require 'rails_helper'

RSpec.describe "indicacoes/index", type: :view do
  before(:each) do
    assign(:indicacoes, [
      Indicacao.create!(
        solicitacao: nil,
        estagiario: nil,
        situacao: "Situacao",
        observacao: "MyText"
      ),
      Indicacao.create!(
        solicitacao: nil,
        estagiario: nil,
        situacao: "Situacao",
        observacao: "MyText"
      )
    ])
  end

  it "renders a list of indicacoes" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Situacao".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
  end
end
