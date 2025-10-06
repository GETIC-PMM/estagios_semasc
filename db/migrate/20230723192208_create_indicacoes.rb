class CreateIndicacoes < ActiveRecord::Migration[7.0]
  def change
    create_table :indicacoes, id: :uuid do |t|
      t.references :solicitacao, null: false, foreign_key: true, type: :uuid
      t.references :estagiario, null: false, foreign_key: true, type: :uuid
      t.string :situacao, default: "em_aberto"
      t.text :observacao
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :indicacoes, :deleted_at
  end
end
