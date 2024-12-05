class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    if current_user.esteban?
      @post = Post.new(post_params)
      @post.user = current_user 
      @post.fecha_publicacion ||= Time.current
      @post.fecha_cierre ||= 1.week.from_now 

      if @post.save
        redirect_to @post, notice: 'Oferta subida exitosamente.'
      else
        render :new
      end
    else
      redirect_to posts_path, alert: 'No tienes permiso para subir ofertas.'
    end
  end
  

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def edit
  end

  private

  def set_post

  end

  def post_params
    params.require(:post).permit(:titulo, :descripcion, :image)
  end
  
end
