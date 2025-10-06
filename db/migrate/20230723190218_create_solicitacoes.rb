class CreateSolicitacoes < ActiveRecord::Migration[7.0]
  def change
    create_table :solicitacoes, id: :uuid do |t|
      t.references :secretaria, null: false, foreign_key: true, type: :uuid
      t.references :curso, null: false, foreign_key: true, type: :uuid
      t.text :perfil
      t.integer :quantidade
      t.string :situacao, default: "aberta"
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :solicitacoes, :deleted_at
  end
end
