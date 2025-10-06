


class Indicacao < ApplicationRecord
    self.implicit_order_column = :created_at
    
    # extends ...................................................................
    
    # includes ..................................................................
    audited
    acts_as_paranoid

    include Searchrable

    # enums
    enum situacao: {
        em_aberto: 'em_aberto',
        selecionado: 'selecionado',
        nao_selecionado: 'nao_selecionado'
    }

    # security (i.e. attr_accessible) ...........................................
        
        
    # relationships .............................................................
    belongs_to :solicitacao, required: true
    belongs_to :estagiario, required: true
    has_one :secretaria, through: :solicitacao
    has_one :curso, through: :solicitacao
    
    # validations ...............................................................
    # callbacks .................................................................
    # scopes ....................................................................
    # additional config .........................................................
    # class methods .............................................................
    # public instance methods ...................................................
    # protected instance methods ................................................
    # private instance methods ..................................................
end
    