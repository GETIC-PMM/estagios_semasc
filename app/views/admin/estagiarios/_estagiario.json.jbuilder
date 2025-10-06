json.extract! estagiario, :id, :nome_completo, :email, :cpf, :telefone, :universidade, :curso_id, :outro_curso, :turno, :ano_ingresso, :ira, :horarios_disponiveis, :possui_graduacao_anterior, :possui_deficiencia, :anexo_documento, :anexo_comprovante_matricula, :anexo_curriculo, :deleted_at, :created_at, :updated_at
json.url admin_estagiario_url(estagiario, format: :json)
