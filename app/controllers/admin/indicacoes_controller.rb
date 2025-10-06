class Admin::IndicacoesController < AdminController
    before_action :set_indicacao, only: [:show, :edit, :update, :destroy]

    load_and_authorize_resource
    # GET /indicacoes
    def index
        unless request.format.in?(['html', 'js'])
            @indicacoes = Indicacao.all
        end
        respond_to do |format|
            format.html
            format.json
            format.js
        end
    end

    # GET /indicacoes/1
    def show;end

    # GET /indicacoes/new
    def new
        @indicacao = Indicacao.new(indicacao_params)
    end

    # GET /indicacoes/1/edit
    def edit;end

    # POST /indicacoes
    def create
        @indicacao = Indicacao.new(indicacao_params)
        notice = 'Indicacao cadastrado(a) com sucesso.'
        respond_to do |format|
            if @indicacao.save
                remote = params.try(:[], :remote)
                location = [:admin, @indicacao]
                location.unshift(params[:controller].split("/")[0].to_sym) if params[:controller].split("/").length > 1
                format.html { redirect_to remote.blank? ? location : admin_indicacoes_path, notice: notice}
                format.json { render :show, status: :created, location: @indicacao }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @indicacao.errors, status: :unprocessable_entity }
                format.turbo_stream { render :form_update, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /indicacoes/1
    def update
        notice = 'Indicacao alterado(a) com sucesso.'
        respond_to do |format|
            if @indicacao.update(indicacao_params)
                remote = params.try(:[], :remote)
                location = [:admin, @indicacao]
                location.unshift(params[:controller].split("/")[0].to_sym) if params[:controller].split("/").length > 1
                format.html { redirect_to remote.blank? ? location : admin_indicacoes_path, notice: notice}
                format.json { render :show, status: :ok, location: location }
                format.js { flash[:notice] = notice}
            else
                format.html { render :edit, status: :unprocessable_entity  }
                format.json { render json: @indicacao.errors, status: :unprocessable_entity }
                format.turbo_stream { render :form_update, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /indicacoes/1
    def destroy
        @indicacao.destroy
        notice = 'Indicacao removido(a) com sucesso.'
        respond_to do |format|
            format.html { redirect_to params[:controller].split("/").map(&:to_sym), notice: notice }
            format.json { head :no_content }
            format.js { render partial: 'shared/errors', locals: {errors: @indicacao.errors} }
        end
    end

    def datatable
        respond_to do |format|
            format.json { render json: Admin::IndicacoesDatatable.new(view_context) }
        end
    end

    def search
        respond_to do |format|
            format.json { render json: Indicacao.search(params[:search])  }
        end
    end

    # PATCH/PUT /indicacoes/1/selecionar
    def selecionar
        notice = 'Estagiário selecionado com sucesso.'
        respond_to do |format|
            if @indicacao.update(situacao: 'selecionado')
                format.html { redirect_to params[:controller].split("/").map(&:to_sym), notice: notice}
                format.json { head :no_content }
                format.js { render partial: 'shared/errors', locals: {errors: @indicacao.errors} }
            end
        end
    end

    # PATCH/PUT /indicacoes/1/nao_selecionar
    def nao_selecionar
        notice = 'Estagiário não selecionado com sucesso.'
        respond_to do |format|
            if @indicacao.update(situacao: 'nao_selecionado')
                format.html { redirect_to params[:controller].split("/").map(&:to_sym), notice: notice}
                format.json { head :no_content }
                format.js { render partial: 'shared/errors', locals: {errors: @indicacao.errors} }
            end
        end
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_indicacao
            @indicacao = Indicacao.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def indicacao_params
            if params[:indicacao]
                    params.require(:indicacao).permit(:solicitacao_id, :estagiario_id, :situacao, :observacao, :deleted_at)
            end
        end


end
    