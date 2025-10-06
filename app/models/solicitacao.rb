


class Solicitacao < ApplicationRecord
    self.implicit_order_column = :created_at
    
    # extends ...................................................................
    
    # includes ..................................................................
    audited
    acts_as_paranoid

    include Searchrable

    enum situacao: { aberta: "aberta", encerrada: "encerrada" }

    # scope
    default_scope -> { Usuario.current.solicitador? ? where({secretaria_id: Usuario.current.secretaria_id}) : where({})}
    scope :abertas, -> { where({situacao: "aberta"}) }

    # security (i.e. attr_accessible) ...........................................
        
        
    # relationships .............................................................
    belongs_to :secretaria, required: true
    belongs_to :curso, required: true
    has_many :indicacoes
    
    # validations ...............................................................
    # callbacks .................................................................
    # scopes ....................................................................
    # additional config .........................................................
    # class methods .............................................................
    # public instance methods ...................................................
    def text
        "#{secretaria.nome} - #{curso.nome} - #{quantidade}"
    end

    def selecionados
        indicacoes.where(situacao: "selecionado")
    end
    # protected instance methods ................................................
    # private instance methods ..................................................
end
    