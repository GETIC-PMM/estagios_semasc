class Admin::EstagiariosDatatable
    delegate :params, :can?, :h, :t, :link_to, :button_to, :content_tag, 
        :admin_estagiario_path, :new_admin_indicacao_path,
        :edit_admin_estagiario_path, to: :@view
  
    
    def initialize(view)
        @view = view
        @remote = params[:remote] == 'true'
    end

    def as_json(_options = {})
        {
            draw: params[:draw].to_i,
            recordsTotal: total,
            recordsFiltered: estagiarios.total_count,
            data: data
        }
    end

    private 
        def data
            estagiarios.each_with_index.map do |estagiario, index|
                {
                    'index' => (index + 1) + ((page - 1) * per_page),
                                            
                                            
                    'nome_completo' => column_nome_completo(estagiario),
                
                                        
                    'cpf' => column_cpf(estagiario),
                
                                        
                    'telefone' => column_telefone(estagiario),
                
                                        
                    'universidade' => column_universidade(estagiario),
                
                                        
                    'curso' => column_curso(estagiario),


                    'ira' => column_ira(estagiario),
                
                                        
                    'possui_deficiencia' => column_possui_deficiencia(estagiario),
                        
                            
                    'opcoes' => column_opcoes(estagiario)
                }
            end
        end


                    
                    
        def column_nome_completo(estagiario)
            result = estagiario.try(:nome_completo)
            result << " <i class='bi bi-send'></i>" if estagiario.indicacoes.present?
            result
        end

            
        def column_cpf(estagiario)
            
                estagiario.try(:cpf)
            
        end
    
            
        def column_telefone(estagiario)
            
                estagiario.try(:telefone)
            
        end
    
            
        def column_universidade(estagiario)
            
                estagiario.try(:universidade)
            
        end
    
            
        def column_curso(estagiario)
            
                estagiario.try(:curso).try(:nome) || estagiario.try(:outro_curso)
            
        end
    
            
        def column_ira(estagiario)
            
                estagiario.try(:ira)
            
        end
    
            
        def column_possui_deficiencia(estagiario)
            
                estagiario.try(:possui_deficiencia) ? "SIM" : "NÃO"
            
        end
            

        
        def column_opcoes(estagiario)
            opcoes = "<div class='sm-hero__datatable-actions'>"

            opcoes << (link_to(admin_estagiario_path(estagiario),
                { remote: @remote, class: 'btn btn-sm btn-primary text-white me-2', title: 'Visualizar',
                data: { toggle: 'tooltip', placement: 'top' } }) do
                content_tag(:i, '', class: 'bi bi-search') + ' Visualizar'
            end).to_s if can? :show, estagiario

            opcoes << (link_to(edit_admin_estagiario_path(estagiario),
                { remote: @remote, class: 'btn btn-sm btn-warning text-dark me-2', title: 'Editar',
                data: { toggle: 'tooltip', placement: 'top' } }) do
                content_tag(:i, '', class: 'bi bi-pencil') + ' Editar'
            end).to_s if can? :edit, estagiario

            opcoes << (button_to admin_estagiario_path(estagiario),
                method: :delete,
                data: { confirm: t('helpers.links.confirm_destroy', model: estagiario.model_name.human), toggle: 'tooltip', placement: 'top' },
                remote: @remote,
                class: 'btn btn-sm btn-danger text-white me-2', title: 'Remover' do
                content_tag(:i, '', class: 'bi bi-trash') + ' Remover'
            end).to_s if can? :destroy, estagiario

            opcoes << (link_to(new_admin_indicacao_path(indicacao: {estagiario_id: estagiario.id}),
                { class: 'btn btn-sm btn-primary text-white me-2', title: 'Indicar',
                data: { toggle: 'tooltip', placement: 'top' } }) do
                content_tag(:i, '', class: 'bi bi-send') + ' Indicar'
            end).to_s if can? :new, Indicacao

            opcoes << "</div>"

            opcoes.html_safe
        end

        def estagiarios
            @estagiarios ||= fetch
        end

        def query
            'Estagiario'
        end

        def fetch
            str_query = query
            params[:columns].each do |column|
                if column[1][:search][:value].present?
                    if column[1][:search][:value] == 'nil'
                        str_query << ".where(#{column[1][:data]}: nil)" 
                    else
                        str_query << ".where(#{column[1][:data]}: '#{column[1][:search][:value]}')" 
                    end
                end
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
            columns = ["created_at", "nome_completo", "cpf", "telefone", "universidade", "curso", "ira", "possui_deficiencia"]
            columns[params[:order]['0'][:column].to_i]
        end

        def sort_direction
            params[:order]['0'][:dir] == 'desc' ? 'desc' : 'asc'
        end


end