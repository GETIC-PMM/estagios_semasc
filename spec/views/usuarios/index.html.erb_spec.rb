require 'rails_helper'

RSpec.describe "usuarios/index", type: :view do
  before(:each) do
    assign(:usuarios, [
      Usuario.create!(
        nome: "Nome",
        permissao: "Permissao",
        email: "Email",
        password: "Password"
      ),
      Usuario.create!(
        nome: "Nome",
        permissao: "Permissao",
        email: "Email",
        password: "Password"
      )
    ])
  end

  it "renders a list of usuarios" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Nome".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Permissao".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Email".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Password".to_s), count: 2
  end
end
