class PostulacionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:create, :destroy]

  def new
    @postulacion = Postulacion.new
  end

  def create
    @post = Post.find(params[:post_id])
    @postulacion = @post.postulacions.new(postulacion_params)
    @postulacion.user = current_user if user_signed_in?
    @postulacion.fecha_postulacion = Time.current
  
    if @postulacion.save
      redirect_to @post, notice: 'Te has postulado exitosamente.'
    else
      redirect_to @post
    end
  end

  def destroy
    @postulacion = Postulacion.find(params[:id])
    
    @postulacion.destroy
    redirect_to @post, notice: 'Postulación eliminada exitosamente.'
  end
  
  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def postulacion_params
    params.require(:postulacion).permit(:fecha_postulacion)
  end
end
