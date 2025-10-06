json.extract! solicitacao, :id, :secretaria_id, :curso_id, :perfil, :quantidade, :situacao, :deleted_at, :created_at, :updated_at
json.url solicitacao_url(solicitacao, format: :json)
