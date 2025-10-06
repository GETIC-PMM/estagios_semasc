require 'rails_helper'

RSpec.describe "secretarias/index", type: :view do
  before(:each) do
    assign(:secretarias, [
      Secretaria.create!(
        nome: "Nome",
        sigla: "Sigla"
      ),
      Secretaria.create!(
        nome: "Nome",
        sigla: "Sigla"
      )
    ])
  end

  it "renders a list of secretarias" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Nome".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Sigla".to_s), count: 2
  end
end
