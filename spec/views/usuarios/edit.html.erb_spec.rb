require 'rails_helper'

RSpec.describe "usuarios/edit", type: :view do
  let(:usuario) {
    Usuario.create!(
      nome: "MyString",
      permissao: "MyString",
      email: "MyString",
      password: "MyString"
    )
  }

  before(:each) do
    assign(:usuario, usuario)
  end

  it "renders the edit usuario form" do
    render

    assert_select "form[action=?][method=?]", admin_usuario_path(usuario), "post" do

      assert_select "input[name=?]", "usuario[nome]"

      assert_select "input[name=?]", "usuario[permissao]"

      assert_select "input[name=?]", "usuario[email]"

      assert_select "input[name=?]", "usuario[password]"
    end
  end
end
