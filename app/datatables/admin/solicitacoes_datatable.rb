class Admin::SolicitacoesDatatable
    include EnumI18nHelper

    delegate :params, :can?, :h, :t, :link_to, :button_to, :content_tag, 
            :admin_solicitacao_path, 
            :edit_admin_solicitacao_path, to: :@view
    
    
    def initialize(view)
        @view = view
        @remote = params[:remote] == 'true'
    end

    def as_json(_options = {})
        {
            draw: params[:draw].to_i,
            recordsTotal: total,
            recordsFiltered: solicitacoes.total_count,
            data: data
        }
    end

    private 
        def data            
            solicitacoes.each_with_index.map do |solicitacao, index|
                {
                    'index' => (index + 1) + ((page - 1) * per_page),
                                            
                                            
                            'secretaria' => column_secretaria(solicitacao),
                        
                                            
                            'curso' => column_curso(solicitacao),
                        
                                            
                            'quantidade' => column_quantidade(solicitacao),


                            'indicacoes' => column_indicacoes(solicitacao),


                            'selecionados' => column_selecionados(solicitacao),
                        
                                            
                            'situacao' => column_situacao(solicitacao),
                        
                    
                    'opcoes' => column_opcoes(solicitacao)
                }
            end
        end


                    
                    
                def column_secretaria(solicitacao)
                    
                        solicitacao.try(:secretaria).try(:nome)
                    
                end
            
                    
                def column_curso(solicitacao)
                    
                        solicitacao.try(:curso).try(:nome)
                    
                end
            
                    
                def column_quantidade(solicitacao)
                    
                        solicitacao.try(:quantidade)
                    
                end


                def column_indicacoes(solicitacao)
                    
                    solicitacao.try(:indicacoes).try(:size)
                
                end


                def column_selecionados(solicitacao)
                    
                    solicitacao.try(:selecionados).try(:size)
                
                end
            
                    
                def column_situacao(solicitacao)
                    
                        enum_i18n(Solicitacao, :situacoes, solicitacao.try(:situacao))
                    
                end
            
        

        
        def column_opcoes(solicitacao)
            opcoes = "<div class='sm-hero__datatable-actions'>"
            
            opcoes << (link_to(admin_solicitacao_path(solicitacao),
                { remote: @remote, class: 'btn btn-sm btn-primary text-white me-2', title: 'Visualizar',
                data: { toggle: 'tooltip', placement: 'top' } }) do
                content_tag(:i, '', class: 'bi bi-search') + ' Visualizar'
            end).to_s if can? :show, solicitacao

            opcoes << (link_to(edit_admin_solicitacao_path(solicitacao),
                { remote: @remote, class: 'btn btn-sm btn-warning text-dark me-2', title: 'Editar',
                data: { toggle: 'tooltip', placement: 'top' } }) do
                content_tag(:i, '', class: 'bi bi-pencil') + ' Editar'
            end).to_s if can? :edit, solicitacao

            opcoes <<  (button_to admin_solicitacao_path(solicitacao),
                method: :delete,
                data: { confirm: t('helpers.links.confirm_destroy', model: solicitacao.model_name.human), toggle: 'tooltip', placement: 'top' },
                remote: @remote,
                class: 'btn btn-sm btn-danger text-white me-2', title: 'Remover' do
                content_tag(:i, '', class: 'bi bi-trash') + ' Remover'
            end).to_s if can? :destroy, solicitacao

            opcoes <<  "</div>"

          
            opcoes.html_safe
        end

        def solicitacoes
            @solicitacoes ||= fetch
        end

        def query
            'Solicitacao'
        end

        def fetch
            str_query = query
            params[:columns].each do |column|
                str_query << ".where(#{column[1][:data]}: '#{column[1][:search][:value]}')" if column[1][:search][:value].present?
            end
            str_query << '.search(params[:search][:value])' if params[:search][:value].present?
            str_query << %{.order("#{sort_column}" => "#{sort_direction}").page(page).per(per_page)}
            eval str_query
        end

        def total
            str_query = query
            str_query << '.count'
            eval str_query
        end

        def page
            params[:start].to_i / per_page + 1
        end
    
        def per_page
            params[:length].to_i.positive? ? params[:length].to_i : 10
        end
    
        def sort_column
            columns = ["created_at", "solicitacoes.secretaria_id", "solicitacoes.curso_id", "quantidade", "indicacoes", "selecionados", "situacao"]
            columns[params[:order]['0'][:column].to_i]
        end

        def sort_direction
            params[:order]['0'][:dir] == 'desc' ? 'desc' : 'asc'
        end
end