class Admin::CursosDatatable
    delegate :params, :can?, :h, :t, :link_to, :button_to, :content_tag, 
        :admin_curso_path, 
        :edit_admin_curso_path, to: :@view
  
    
    def initialize(view)
        @view = view
        @remote = params[:remote] == 'true'
    end

    def as_json(_options = {})
        {
            draw: params[:draw].to_i,
            recordsTotal: total,
            recordsFiltered: cursos.total_count,
            data: data
        }
    end

    private 
        def data
            cursos.each_with_index.map do |curso, index|
                {
                    'index' => (index + 1) + ((page - 1) * per_page),
                                            
                                            
                    'nome' => column_nome(curso),
                        
                    
                    'opcoes' => column_opcoes(curso)
                }
            end
        end


                    
                    
                def column_nome(curso)
                    
                        curso.try(:nome)
                    
                end
            
        

        
        def column_opcoes(curso)
            opcoes = "<div class='sm-hero__datatable-actions'>"

            opcoes << (link_to(admin_curso_path(curso),
                { remote: @remote, class: 'btn btn-sm btn-primary text-white me-2', title: 'Visualizar',
                data: { toggle: 'tooltip', placement: 'top' } }) do
                content_tag(:i, '', class: 'bi bi-search') + ' Visualizar'
            end).to_s if can? :show, curso

            opcoes << (link_to(edit_admin_curso_path(curso),
                { remote: @remote, class: 'btn btn-sm btn-warning text-dark me-2', title: 'Editar',
                data: { toggle: 'tooltip', placement: 'top' } }) do
                content_tag(:i, '', class: 'bi bi-pencil') + ' Editar'
            end).to_s if can? :edit, curso

            opcoes << (button_to admin_curso_path(curso),
                method: :delete,
                data: { confirm: t('helpers.links.confirm_destroy', model: curso.model_name.human), toggle: 'tooltip', placement: 'top' },
                remote: @remote,
                class: 'btn btn-sm btn-danger text-white me-2', title: 'Remover' do
                content_tag(:i, '', class: 'bi bi-trash') + ' Remover'
            end).to_s if can? :destroy, curso

            opcoes << "</div>"

            opcoes.html_safe
        end

        def cursos
            @cursos ||= fetch
        end

        def query
            'Curso'
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
            columns = ["created_at", "nome"]
            columns[params[:order]['0'][:column].to_i]
        end

        def sort_direction
            params[:order]['0'][:dir] == 'desc' ? 'desc' : 'asc'
        end


end