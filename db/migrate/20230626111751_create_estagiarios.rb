class CreateEstagiarios < ActiveRecord::Migration[7.0]
  def change
    create_table :estagiarios, id: :uuid do |t|
      t.string :nome_completo
      t.string :email
      t.string :cpf
      t.string :telefone
      t.string :instituicao_ensino
      t.string :outro_curso
      t.references :curso, null: true, foreign_key: true, type: :uuid
      t.string :turno
      t.string :ano_ingresso
      t.decimal :ira
      t.string :horarios_disponiveis, array: true, default: []
      t.boolean :possui_graduacao_anterior
      t.boolean :possui_deficiencia
      t.string :anexo_documento
      t.string :anexo_comprovante_matricula
      t.string :anexo_curriculo
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :estagiarios, :deleted_at
  end
end
