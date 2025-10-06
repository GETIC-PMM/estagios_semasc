class Admin::IndicacoesDatatable
    include EnumI18nHelper

    delegate :params, :can?, :h, :t, :link_to, :button_to, :content_tag, 
            :admin_indicacao_path, 
            :edit_admin_indicacao_path,
            :selecionar_admin_indicacao_path,
            :nao_selecionar_admin_indicacao_path, to: :@view
    
    
    def initialize(view)
        @view = view
        @remote = params[:remote] == 'true'
    end

    def as_json(_options = {})
        {
            draw: params[:draw].to_i,
            recordsTotal: total,
            recordsFiltered: indicacoes.total_count,
            data: data
        }
    end

    private 
        def data            
            indicacoes.each_with_index.map do |indicacao, index|
                {
                    'index' => (index + 1) + ((page - 1) * per_page),
                                            
                                            
                            'secretaria' => column_secretaria(indicacao),


                            'curso' => column_curso(indicacao),
                        
                                            
                            'estagiario' => column_estagiario(indicacao),


                            'ira' => column_ira(indicacao),
                        
                                            
                            'situacao' => column_situacao(indicacao),
                        
                    
                    'opcoes' => column_opcoes(indicacao)
                }
            end
        end


                    
                    
                def column_secretaria(indicacao)
                    
                        indicacao.try(:secretaria).try(:nome)
                    
                end


                def column_curso(indicacao)
                    
                        indicacao.try(:curso).try(:nome)
                
                end
            
                    
                def column_estagiario(indicacao)
                    
                        indicacao.try(:estagiario).try(:nome_completo)
                    
                end
            
                    
                def column_ira(indicacao)
                    
                        indicacao.try(:estagiario).try(:ira)
                    
                end
            
                    
                def column_situacao(indicacao)
                    
                        enum_i18n(Indicacao, :situacoes, indicacao.try(:situacao))
                    
                end
            
        

        
        def column_opcoes(indicacao)
            opcoes = "<div class='sm-hero__datatable-actions'>"
            
            opcoes << (link_to(admin_indicacao_path(indicacao),
                { remote: @remote, class: 'btn btn-sm btn-primary text-white me-2', title: 'Visualizar',
                data: { toggle: 'tooltip', placement: 'top' } }) do
                content_tag(:i, '', class: 'bi bi-search') + ' Visualizar'
            end).to_s if can? :show, indicacao

            opcoes << (link_to(edit_admin_indicacao_path(indicacao),
                { remote: @remote, class: 'btn btn-sm btn-warning text-dark me-2', title: 'Editar',
                data: { toggle: 'tooltip', placement: 'top' } }) do
                content_tag(:i, '', class: 'bi bi-pencil') + ' Editar'
            end).to_s if can? :edit, indicacao

            opcoes <<  (button_to admin_indicacao_path(indicacao),
                method: :delete,
                data: { confirm: t('helpers.links.confirm_destroy', model: indicacao.model_name.human), toggle: 'tooltip', placement: 'top' },
                remote: @remote,
                class: 'btn btn-sm btn-danger text-white me-2', title: 'Remover' do
                content_tag(:i, '', class: 'bi bi-trash') + ' Remover'
            end).to_s if can? :destroy, indicacao

            opcoes << (button_to selecionar_admin_indicacao_path(indicacao),
                method: :put,
                data: { confirm: 'Deseja realmente selecionar o estagiário?', toggle: 'tooltip', placement: 'top' },
                remote: @remote, 
                class: 'btn btn-sm btn-primary text-white me-2', title: 'Selecionar' do
                content_tag(:i, '', class: 'bi bi-hand-thumbs-up-fill') + ' Selecionar'
            end).to_s if (can? :selecionar, indicacao) && !indicacao.selecionado?

            opcoes << (button_to nao_selecionar_admin_indicacao_path(indicacao),
                method: :put,
                data: { confirm: 'Deseja realmente não selecionar o estagiário?', toggle: 'tooltip', placement: 'top' },
                remote: @remote, 
                class: 'btn btn-sm btn-danger text-white me-2', title: 'Não selecionar' do
                content_tag(:i, '', class: 'bi bi-hand-thumbs-down-fill') + ' Não selecionar'
            end).to_s if (can? :nao_selecionar, indicacao) && !indicacao.nao_selecionado?

            opcoes <<  "</div>"

          
            opcoes.html_safe
        end

        def indicacoes
            @indicacoes ||= fetch
        end

        def query
            str_query = 'Indicacao'
            str_query << ".where(solicitacao_id: params[:solicitacao_id])" if params[:solicitacao_id].present?
            str_query << ".where(estagiario_id: params[:estagiario_id])" if params[:estagiario_id].present?
            str_query
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
            columns = ["created_at", "secretaria", "curso", "estagiario", "ira", "situacao"]
            columns[params[:order]['0'][:column].to_i]
        end

        def sort_direction
            params[:order]['0'][:dir] == 'desc' ? 'desc' : 'asc'
        end
end