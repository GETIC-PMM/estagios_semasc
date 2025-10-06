# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_07_23_200319) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "active_storage_attachments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.uuid "record_id", null: false
    t.uuid "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "audits", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "auditable_id"
    t.string "auditable_type"
    t.uuid "associated_id"
    t.string "associated_type"
    t.uuid "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "cursos", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "nome"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_cursos_on_deleted_at"
  end

  create_table "custom_auto_increments", force: :cascade do |t|
    t.string "counter_model_name"
    t.integer "counter", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["counter_model_name"], name: "index_custom_auto_increments_on_counter_model_name"
  end

  create_table "estagiarios", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "nome_completo"
    t.string "email"
    t.string "cpf"
    t.string "telefone"
    t.string "instituicao_ensino"
    t.string "outro_curso"
    t.uuid "curso_id"
    t.string "turno"
    t.string "ano_ingresso"
    t.decimal "ira"
    t.string "horarios_disponiveis", default: [], array: true
    t.boolean "possui_graduacao_anterior"
    t.boolean "possui_deficiencia"
    t.string "anexo_documento"
    t.string "anexo_comprovante_matricula"
    t.string "anexo_curriculo"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["curso_id"], name: "index_estagiarios_on_curso_id"
    t.index ["deleted_at"], name: "index_estagiarios_on_deleted_at"
  end

  create_table "indicacoes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "solicitacao_id", null: false
    t.uuid "estagiario_id", null: false
    t.string "situacao", default: "em_aberto"
    t.text "observacao"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_indicacoes_on_deleted_at"
    t.index ["estagiario_id"], name: "index_indicacoes_on_estagiario_id"
    t.index ["solicitacao_id"], name: "index_indicacoes_on_solicitacao_id"
  end

  create_table "secretarias", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "nome"
    t.string "sigla"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "seed_migration_data_migrations", force: :cascade do |t|
    t.string "version"
    t.integer "runtime"
    t.datetime "migrated_on"
  end

  create_table "solicitacoes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "secretaria_id", null: false
    t.uuid "curso_id", null: false
    t.text "perfil"
    t.integer "quantidade"
    t.string "situacao", default: "aberta"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["curso_id"], name: "index_solicitacoes_on_curso_id"
    t.index ["deleted_at"], name: "index_solicitacoes_on_deleted_at"
    t.index ["secretaria_id"], name: "index_solicitacoes_on_secretaria_id"
  end

  create_table "usuarios", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "nome"
    t.string "permissao"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "secretaria_id"
    t.index ["deleted_at"], name: "index_usuarios_on_deleted_at"
    t.index ["email"], name: "index_usuarios_on_email", unique: true
    t.index ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true
    t.index ["secretaria_id"], name: "index_usuarios_on_secretaria_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "estagiarios", "cursos"
  add_foreign_key "indicacoes", "estagiarios"
  add_foreign_key "indicacoes", "solicitacoes"
  add_foreign_key "solicitacoes", "cursos"
  add_foreign_key "solicitacoes", "secretarias"
  add_foreign_key "usuarios", "secretarias"
end
