class Admin::SecretariasDatatable
    delegate :params, :can?, :h, :t, :link_to, :button_to, :content_tag, 
            :admin_secretaria_path, 
            :edit_admin_secretaria_path, to: :@view
    
    
    def initialize(view)
        @view = view
        @remote = params[:remote] == 'true'
    end

    def as_json(_options = {})
        {
            draw: params[:draw].to_i,
            recordsTotal: total,
            recordsFiltered: secretarias.total_count,
            data: data
        }
    end

    private 
        def data            
            secretarias.each_with_index.map do |secretaria, index|
                {
                    'index' => (index + 1) + ((page - 1) * per_page),
                                            
                                            
                            'nome' => column_nome(secretaria),
                        
                                            
                            'sigla' => column_sigla(secretaria),
                        
                    
                    'opcoes' => column_opcoes(secretaria)
                }
            end
        end


                    
                    
                def column_nome(secretaria)
                    
                        secretaria.try(:nome)
                    
                end
            
                    
                def column_sigla(secretaria)
                    
                        secretaria.try(:sigla)
                    
                end
            
        

        
        def column_opcoes(secretaria)
            opcoes = "<div class='sm-hero__datatable-actions'>"
            
            opcoes << (link_to(admin_secretaria_path(secretaria),
                { remote: @remote, class: 'btn btn-sm btn-primary text-white me-2', title: 'Visualizar',
                data: { toggle: 'tooltip', placement: 'top' } }) do
                content_tag(:i, '', class: 'bi bi-search') + ' Visualizar'
            end).to_s if can? :show, secretaria

            opcoes << (link_to(edit_admin_secretaria_path(secretaria),
                { remote: @remote, class: 'btn btn-sm btn-warning text-dark me-2', title: 'Editar',
                data: { toggle: 'tooltip', placement: 'top' } }) do
                content_tag(:i, '', class: 'bi bi-pencil') + ' Editar'
            end).to_s if can? :edit, secretaria

            opcoes <<  (button_to admin_secretaria_path(secretaria),
                method: :delete,
                data: { confirm: t('helpers.links.confirm_destroy', model: secretaria.model_name.human), toggle: 'tooltip', placement: 'top' },
                remote: @remote,
                class: 'btn btn-sm btn-danger text-white me-2', title: 'Remover' do
                content_tag(:i, '', class: 'bi bi-trash') + ' Remover'
            end).to_s if can? :destroy, secretaria

            opcoes <<  "</div>"

          
            opcoes.html_safe
        end

        def secretarias
            @secretarias ||= fetch
        end

        def query
            'Secretaria'
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
            columns = ["created_at", "nome", "sigla"]
            columns[params[:order]['0'][:column].to_i]
        end

        def sort_direction
            params[:order]['0'][:dir] == 'desc' ? 'desc' : 'asc'
        end
end