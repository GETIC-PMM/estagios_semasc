class Admin::SolicitacoesController < AdminController
    before_action :set_solicitacao, only: [:show, :edit, :update, :destroy]

    load_and_authorize_resource
    # GET /solicitacoes
    def index
        unless request.format.in?(['html', 'js'])
            @solicitacoes = Solicitacao.all
        end
        respond_to do |format|
            format.html
            format.json
            format.js
        end
    end

    # GET /solicitacoes/1
    def show;end

    # GET /solicitacoes/new
    def new
        @solicitacao = Solicitacao.new(solicitacao_params)
    end

    # GET /solicitacoes/1/edit
    def edit;end

    # POST /solicitacoes
    def create
        @solicitacao = Solicitacao.new(solicitacao_params)
        notice = 'Solicitacao cadastrado(a) com sucesso.'
        respond_to do |format|
            if @solicitacao.save
                remote = params.try(:[], :remote)
                location = [:admin, @solicitacao]
                location.unshift(params[:controller].split("/")[0].to_sym) if params[:controller].split("/").length > 1
                format.html { redirect_to remote.blank? ? location : admin_solicitacoes_path, notice: notice}
                format.json { render :show, status: :created, location: @solicitacao }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @solicitacao.errors, status: :unprocessable_entity }
                format.turbo_stream { render :form_update, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /solicitacoes/1
    def update
        notice = 'Solicitacao alterado(a) com sucesso.'
        respond_to do |format|
            if @solicitacao.update(solicitacao_params)
                remote = params.try(:[], :remote)
                location = [:admin, @solicitacao]
                location.unshift(params[:controller].split("/")[0].to_sym) if params[:controller].split("/").length > 1
                format.html { redirect_to remote.blank? ? location : admin_solicitacoes_path, notice: notice}
                format.json { render :show, status: :ok, location: location }
                format.js { flash[:notice] = notice}
            else
                format.html { render :edit, status: :unprocessable_entity  }
                format.json { render json: @solicitacao.errors, status: :unprocessable_entity }
                format.turbo_stream { render :form_update, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /solicitacoes/1
    def destroy
        @solicitacao.destroy
        notice = 'Solicitacao removido(a) com sucesso.'
        respond_to do |format|
            format.html { redirect_to params[:controller].split("/").map(&:to_sym), notice: notice }
            format.json { head :no_content }
            format.js { render partial: 'shared/errors', locals: {errors: @solicitacao.errors} }
        end
    end

    def datatable
        respond_to do |format|
            format.json { render json: Admin::SolicitacoesDatatable.new(view_context) }
        end
    end

    def search
        respond_to do |format|
            format.json { render json: Solicitacao.search(params[:search])  }
        end
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_solicitacao
            @solicitacao = Solicitacao.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def solicitacao_params
            if params[:solicitacao]
                    params.require(:solicitacao).permit(:secretaria_id, :curso_id, :perfil, :quantidade, :situacao, :deleted_at)
            end
        end


end
    