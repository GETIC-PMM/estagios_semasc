require 'rails_helper'

RSpec.describe "solicitacoes/show", type: :view do
  before(:each) do
    assign(:solicitacao, Solicitacao.create!(
      secretaria: nil,
      curso: nil,
      perfil: "MyText",
      quantidade: 2,
      situacao: "Situacao"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Situacao/)
  end
end
