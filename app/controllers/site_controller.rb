class SiteController < ActionController::Base
  protect_from_forgery prepend: true, with: :exception
  protect_from_forgery prepend: true, with: :null_session, if: proc { |c| c.request.format == 'application/json' }  

  after_action :flash_to_headers

  def index
    @estagiario = Estagiario.new
  end

  # POST /estagiarios
  def estagiarios
    @estagiario = Estagiario.new(estagiario_params)
    respond_to do |format|
        if verify_recaptcha(model: @estagiario) && @estagiario.save
            format.html { redirect_to root_path, notice: 'Inscrição realizada com sucesso.'}
        else
            format.html { render :index, status: :unprocessable_entity, notice: 'Confira os dados informados.' }
        end
    end
  end

  def update_curriculo
    @estagiario = Estagiario.find(params[:id])
    respond_to do |format|
      if @estagiario.update(estagiario_params)
        format.js { flash[:notice] = 'Estagiário atualizado com sucesso.' }
      else
        format.js { flash[:notice] = 'Confira os dados informados.' }
      end
    end
  end

  def consulta;end

  def consultar
    @errors = []
    if verify_recaptcha
        @estagiario = Estagiario.where(cpf: params[:cpf]).take
        @errors << "Nenhum estagiário encontrado para os dados informados. Confira os dados." if @estagiario.blank?
    else
        @errors << "A verificação do reCAPTCHA falhou. Tente novamente."
    end
    respond_to do |format|
        format.html { render :consulta }
    end
  end

  def flash_to_headers
      return unless request.xhr?
      response.headers['X-Message'] = flash_message
      response.headers["X-Message-Type"] = flash_type.to_s
      flash.discard # don't want the flash to appear when you reload page
  end

  private
      def flash_message
          [:error, :warning, :notice].each do |type|
              return flash[type] unless flash[type].blank?
          end
      end

      def flash_type
          [:error, :warning, :notice].each do |type|
              return type unless flash[type].blank?
          end
      end

      def estagiario_params
        if params[:estagiario]
            params.require(:estagiario).permit(
                :nome_completo, 
                :email, 
                :cpf, 
                :telefone,
                :curso_id, 
                :outro_curso,
                :turno, 
                :ano_ingresso, 
                :ira, 
                :possui_graduacao_anterior, 
                :possui_deficiencia, 
                :anexo_documento, 
                :anexo_comprovante_matricula,
                :anexo_certificado,
                :anexo_curriculo,
                :declaro_ciencia,
                :instituicao_ensino,
                :declaro_veracidade,
                horarios_disponiveis: []
            )
        end
    end
end
