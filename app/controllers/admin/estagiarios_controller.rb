class Admin::EstagiariosController < AdminController
    before_action :set_estagiario, only: [:show, :edit, :update, :destroy]

    load_and_authorize_resource
    # GET /estagiarios
    def index
        unless request.format.in?(['html', 'js'])
            @estagiarios = Estagiario.all
        end
        respond_to do |format|
            format.html
            format.json
            format.js
        end
    end

    # GET /estagiarios/1
    def show;end

    # GET /estagiarios/new
    def new
        @estagiario = Estagiario.new(estagiario_params)
    end

    # GET /estagiarios/1/edit
    def edit;end

    # POST /estagiarios
    def create
        @estagiario = Estagiario.new(estagiario_params)
        notice = 'Estagiario cadastrado(a) com sucesso.'
        respond_to do |format|
            if @estagiario.save
                remote = params.try(:[], :remote)
                location = [@estagiario]
                location.unshift(params[:controller].split("/")[0].to_sym) if params[:controller].split("/").length > 1
                format.html { redirect_to remote.blank? ? location : admin_estagiarios_path, notice: notice}
                format.json { render :show, status: :created, location: @estagiario }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @estagiario.errors, status: :unprocessable_entity }
                format.turbo_stream { render :form_update, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /estagiarios/1
    def update
        notice = 'Estagiario alterado(a) com sucesso.'
        respond_to do |format|
            if @estagiario.update(estagiario_params)
                remote = params.try(:[], :remote)
                location = [@estagiario]
                location.unshift(params[:controller].split("/")[0].to_sym) if params[:controller].split("/").length > 1
                format.html { redirect_to remote.blank? ? location : admin_estagiarios_path, notice: notice}
                format.json { render :show, status: :ok, location: location }
                format.js { flash[:notice] = notice}
            else
                format.html { render :edit, status: :unprocessable_entity  }
                format.json { render json: @estagiario.errors, status: :unprocessable_entity }
                format.turbo_stream { render :form_update, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /estagiarios/1
    def destroy
        @estagiario.destroy
        notice = 'Estagiario removido(a) com sucesso.'
        respond_to do |format|
            format.html { redirect_to params[:controller].split("/").map(&:to_sym), notice: notice }
            format.json { head :no_content }
            format.js { render partial: 'shared/errors', locals: {errors: @estagiario.errors} }
        end
    end

    def datatable
        respond_to do |format|
            format.json { render json: Admin::EstagiariosDatatable.new(view_context) }
        end
    end

    def search
        respond_to do |format|
            format.json { render json: Estagiario.search(params[:search])  }
        end
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_estagiario
            @estagiario = Estagiario.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def estagiario_params
            if params[:estagiario]
                params.require(:estagiario).permit(
                    :nome_completo, 
                    :email, 
                    :cpf, 
                    :telefone, 
                    :universidade, 
                    :curso_id, 
                    :outro_curso,
                    :turno, 
                    :ano_ingresso, 
                    :ira, 
                    :horarios_disponiveis, 
                    :possui_graduacao_anterior, 
                    :possui_deficiencia, 
                    :anexo_documento, 
                    :anexo_comprovante_matricula, 
                    :anexo_curriculo 
                )
            end
        end


end
    