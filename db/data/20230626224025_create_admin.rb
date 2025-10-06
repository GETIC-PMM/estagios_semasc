class CreateAdmin < SeedMigration::Migration
  def up
    Usuario.create({nome: "Administrador", email: "ti@prefeiturademossoro.com.br", permissao: "admin", password: "G3t1c@estagiarios"})
  end

  def down

  end
end
