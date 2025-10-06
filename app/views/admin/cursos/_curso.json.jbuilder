json.extract! curso, :id, :nome, :deleted_at, :created_at, :updated_at
json.url admin_curso_url(curso, format: :json)
