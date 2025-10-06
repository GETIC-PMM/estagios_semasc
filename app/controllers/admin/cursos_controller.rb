class Admin::CursosController < AdminController
    before_action :set_curso, only: [:show, :edit, :update, :destroy]

    load_and_authorize_resource
    # GET /cursos
    def index
        unless request.format.in?(['html', 'js'])
            @cursos = Curso.all
        end
        respond_to do |format|
            format.html
            format.json
            format.js
        end
    end

    # GET /cursos/1
    def show;end

    # GET /cursos/new
    def new
        @curso = Curso.new(curso_params)
    end

    # GET /cursos/1/edit
    def edit;end

    # POST /cursos
    def create
        @curso = Curso.new(curso_params)
        notice = 'Curso cadastrado(a) com sucesso.'
        respond_to do |format|
            if @curso.save
                remote = params.try(:[], :remote)
                location = [@curso]
                location.unshift(params[:controller].split("/")[0].to_sym) if params[:controller].split("/").length > 1
                format.html { redirect_to remote.blank? ? location : admin_cursos_path, notice: notice}
                format.json { render :show, status: :created, location: @curso }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @curso.errors, status: :unprocessable_entity }
                format.turbo_stream { render :form_update, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /cursos/1
    def update
        notice = 'Curso alterado(a) com sucesso.'
        respond_to do |format|
            if @curso.update(curso_params)
                remote = params.try(:[], :remote)
                location = [@curso]
                location.unshift(params[:controller].split("/")[0].to_sym) if params[:controller].split("/").length > 1
                format.html { redirect_to remote.blank? ? location : admin_cursos_path, notice: notice}
                format.json { render :show, status: :ok, location: location }
                format.js { flash[:notice] = notice}
            else
                format.html { render :edit, status: :unprocessable_entity  }
                format.json { render json: @curso.errors, status: :unprocessable_entity }
                format.turbo_stream { render :form_update, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /cursos/1
    def destroy
        @curso.destroy
        notice = 'Curso removido(a) com sucesso.'
        respond_to do |format|
            format.html { redirect_to params[:controller].split("/").map(&:to_sym), notice: notice }
            format.json { head :no_content }
            format.js { render partial: 'shared/errors', locals: {errors: @curso.errors} }
        end
    end

    def datatable
        respond_to do |format|
            format.json { render json: Admin::CursosDatatable.new(view_context) }
        end
    end

    def search
        respond_to do |format|
            format.json { render json: Curso.search(params[:search])  }
        end
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_curso
            @curso = Curso.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def curso_params
            if params[:curso]
                    params.require(:curso).permit(:nome, :deleted_at)
            end
        end


end
    