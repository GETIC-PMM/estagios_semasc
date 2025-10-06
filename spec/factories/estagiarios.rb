FactoryBot.define do
  factory :estagiario do
    nome_completo { "MyString" }
    email { "MyString" }
    cpf { "MyString" }
    telefone { "MyString" }
    universidade { nil }
    curso { nil }
    turno { "MyString" }
    ano_ingresso { "MyString" }
    ira { "9.99" }
    horarios_disponiveis { "MyString" }
    possui_graduacao_anterior { false }
    possui_deficiencia { false }
    anexo_documento { "MyString" }
    anexo_comprovante_matricula { "MyString" }
    anexo_curriculo { "MyString" }
    deleted_at { "2023-06-26 08:17:52" }
  end
end
