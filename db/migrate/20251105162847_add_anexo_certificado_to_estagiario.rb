class AddAnexoCertificadoToEstagiario < ActiveRecord::Migration[7.0]
  def change
    add_column :estagiarios, :anexo_certificado, :string
  end
end
