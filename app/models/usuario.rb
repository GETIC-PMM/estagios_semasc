


class Usuario < ApplicationRecord
  self.implicit_order_column = :created_at
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  # extends ...................................................................
  
  # includes ..................................................................
  audited
  acts_as_paranoid

  include Searchrable

  # scope
  default_scope -> { Usuario.current.present? && Usuario.current.solicitador? ? where({secretaria_id: Usuario.current.secretaria_id}) : where({})}

  # security (i.e. attr_accessible) ...........................................
      
  # enuns
  enum permissao: { admin: "admin", solicitador: "solicitador" }
      
  # relationships .............................................................
  belongs_to :secretaria, required: false

  # validations ...............................................................
  validate_enum_attribute :permissao
  validates :secretaria, presence: true, if: :solicitador?
  # callbacks .................................................................
  # scopes ....................................................................
  # additional config .........................................................
  # class methods .............................................................
  # public instance methods ...................................................
  # protected instance methods ................................................
  # private instance methods ..................................................

  private
    def self.current=(usuario)
      Thread.current[:current_usuario] = usuario
    end

    def self.current
      Thread.current[:current_usuario]
    end
end
    