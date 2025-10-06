FactoryBot.define do
  factory :solicitacao do
    secretaria { nil }
    curso { nil }
    perfil { "MyText" }
    quantidade { 1 }
    situacao { "MyString" }
    deleted_at { "2023-07-23 16:02:18" }
  end
end
