FactoryBot.define do
  factory :indicacao do
    solicitacao { nil }
    estagiario { nil }
    situacao { "MyString" }
    observacao { "MyText" }
    deleted_at { "2023-07-23 16:22:08" }
  end
end
