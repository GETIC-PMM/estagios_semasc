class PopularCursos < SeedMigration::Migration
  def up

    Curso.create([
      {nome: "Direito"},
      {nome: "Administração"},
      {nome: "Assistência Social "},
      {nome: "Psicologia"},
      {nome: "Pedagogia "},
      {nome: "Licenciaturas"},
      {nome: "Contabilidade "},
      {nome: "Engenharia"},
      {nome: "Arquitetura"},
      {nome: "Jornalismo "}
    ])

  end

  def down

  end
end
