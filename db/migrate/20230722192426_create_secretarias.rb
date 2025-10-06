class CreateSecretarias < ActiveRecord::Migration[7.0]
  def change
    create_table :secretarias, id: :uuid do |t|
      t.string :nome
      t.string :sigla
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
