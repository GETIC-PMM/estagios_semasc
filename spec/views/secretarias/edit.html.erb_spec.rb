require 'rails_helper'

RSpec.describe "secretarias/edit", type: :view do
  let(:secretaria) {
    Secretaria.create!(
      nome: "MyString",
      sigla: "MyString"
    )
  }

  before(:each) do
    assign(:secretaria, secretaria)
  end

  it "renders the edit secretaria form" do
    render

    assert_select "form[action=?][method=?]", secretaria_path(secretaria), "post" do

      assert_select "input[name=?]", "secretaria[nome]"

      assert_select "input[name=?]", "secretaria[sigla]"
    end
  end
end
