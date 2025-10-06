class Admin::SecretariasController < AdminController
    before_action :set_secretaria, only: [:show, :edit, :update, :destroy]

    load_and_authorize_resource
    # GET /secretarias
    def index
        unless request.format.in?(['html', 'js'])
            @secretarias = Secretaria.all
        end
        respond_to do |format|
            format.html
            format.json
            format.js
        end
    end

    # GET /secretarias/1
    def show;end

    # GET /secretarias/new
    def new
        @secretaria = Secretaria.new(secretaria_params)
    end

    # GET /secretarias/1/edit
    def edit;end

    # POST /secretarias
    def create
        @secretaria = Secretaria.new(secretaria_params)
        notice = 'Secretaria cadastrado(a) com sucesso.'
        respond_to do |format|
            if @secretaria.save
                remote = params.try(:[], :remote)
                location = [:admin, @secretaria]
                location.unshift(params[:controller].split("/")[0].to_sym) if params[:controller].split("/").length > 1
                format.html { redirect_to remote.blank? ? location : admin_secretarias_path, notice: notice}
                format.json { render :show, status: :created, location: @secretaria }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @secretaria.errors, status: :unprocessable_entity }
                format.turbo_stream { render :form_update, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /secretarias/1
    def update
        notice = 'Secretaria alterado(a) com sucesso.'
        respond_to do |format|
            if @secretaria.update(secretaria_params)
                remote = params.try(:[], :remote)
                location = [:admin, @secretaria]
                location.unshift(params[:controller].split("/")[0].to_sym) if params[:controller].split("/").length > 1
                format.html { redirect_to remote.blank? ? location : admin_secretarias_path, notice: notice}
                format.json { render :show, status: :ok, location: location }
                format.js { flash[:notice] = notice}
            else
                format.html { render :edit, status: :unprocessable_entity  }
                format.json { render json: @secretaria.errors, status: :unprocessable_entity }
                format.turbo_stream { render :form_update, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /secretarias/1
    def destroy
        @secretaria.destroy
        notice = 'Secretaria removido(a) com sucesso.'
        respond_to do |format|
            format.html { redirect_to params[:controller].split("/").map(&:to_sym), notice: notice }
            format.json { head :no_content }
            format.js { render partial: 'shared/errors', locals: {errors: @secretaria.errors} }
        end
    end

    def datatable
        respond_to do |format|
            format.json { render json: Admin::SecretariasDatatable.new(view_context) }
        end
    end

    def search
        respond_to do |format|
            format.json { render json: Secretaria.search(params[:search])  }
        end
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_secretaria
            @secretaria = Secretaria.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def secretaria_params
            if params[:secretaria]
                    params.require(:secretaria).permit(:nome, :sigla, :deleted_at)
            end
        end


end
    