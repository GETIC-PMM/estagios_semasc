require 'rails_helper'

RSpec.describe "secretarias/new", type: :view do
  before(:each) do
    assign(:secretaria, Secretaria.new(
      nome: "MyString",
      sigla: "MyString"
    ))
  end

  it "renders new secretaria form" do
    render

    assert_select "form[action=?][method=?]", secretarias_path, "post" do

      assert_select "input[name=?]", "secretaria[nome]"

      assert_select "input[name=?]", "secretaria[sigla]"
    end
  end
end
