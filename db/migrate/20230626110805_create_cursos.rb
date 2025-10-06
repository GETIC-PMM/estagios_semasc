class CreateCursos < ActiveRecord::Migration[7.0]
  def change
    create_table :cursos, id: :uuid do |t|
      t.string :nome
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :cursos, :deleted_at
  end
end
