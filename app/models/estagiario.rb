


class Estagiario < ApplicationRecord
    self.implicit_order_column = :created_at
    
    # extends ...................................................................
    extend ArrayEnum
    
    # includes ..................................................................
    audited
    acts_as_paranoid

    include Searchrable

    # scopes
    scope :ordenado, -> { joins(:curso).order("cursos.nome ASC").order(ira: :desc) }

    # uploaders
    mount_uploader :anexo_documento, DocumentoUploader
    mount_uploader :anexo_curriculo, DocumentoUploader
    mount_uploader :anexo_comprovante_matricula, DocumentoUploader
    mount_uploader :anexo_certificado, DocumentoUploader
    # has_one_attached :anexo_documento
    # has_one_attached :anexo_curriculo
    # has_one_attached :anexo_comprovante_matricula

    # security (i.e. attr_accessible) ...........................................
    attr_accessor :declaro_ciencia, :declaro_veracidade
        
    # relationships .............................................................
    belongs_to :curso, required: false
    has_many :indicacoes

    # enuns
    enum turno: {
        manha: 'manha',
        tarde: 'tarde',
        noite: 'noite'
    }

    array_enum horarios_disponiveis: {
        manha: 'manha',
        tarde: 'tarde',
        noite: 'noite'
    }
    
    # validations ...............................................................
    validates :nome_completo, :email, :cpf, :telefone, :turno, :ano_ingresso, 
        :horarios_disponiveis, :anexo_documento, :anexo_curriculo,
        :anexo_comprovante_matricula, :declaro_ciencia, :declaro_veracidade, presence: true, on: :create
    validates :possui_graduacao_anterior, inclusion: [true, false], on: :create
    validates :possui_deficiencia, inclusion: [true, false], on: :create
    validates :cpf, uniqueness: true, on: :create
    validate_enum_attributes :contratacao, :tipo, on: :create
    validate :valid_curso, on: :create
    # callbacks .................................................................
    # scopes ....................................................................
    # additional config .........................................................
    # class methods .............................................................
    # public instance methods ...................................................
    def text
        "#{nome_completo} - #{curso.try(:nome) || outro_curso} - #{ira}"
    end
    # protected instance methods ................................................
    # private instance methods ..................................................
    private
    def valid_curso
        self.errors.add(:curso_id, "não pode estar em branco") if self.curso.blank? && self.outro_curso.blank?
    end
end
    