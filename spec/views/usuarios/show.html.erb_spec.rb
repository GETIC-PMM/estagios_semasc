require 'rails_helper'

RSpec.describe "usuarios/show", type: :view do
  before(:each) do
    assign(:usuario, Usuario.create!(
      nome: "Nome",
      permissao: "Permissao",
      email: "Email",
      password: "Password"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Nome/)
    expect(rendered).to match(/Permissao/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Password/)
  end
end
