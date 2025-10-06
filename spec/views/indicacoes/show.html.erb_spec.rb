require 'rails_helper'

RSpec.describe "indicacoes/show", type: :view do
  before(:each) do
    assign(:indicacao, Indicacao.create!(
      solicitacao: nil,
      estagiario: nil,
      situacao: "Situacao",
      observacao: "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Situacao/)
    expect(rendered).to match(/MyText/)
  end
end
