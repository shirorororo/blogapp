class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  def index
     @blogs = Blog.all 
  end


  def new
    if params[:back]
      @blog = Blog.new(blog_params)
    else
      @blog = Blog.new
    end
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    if @blog.save
      NotificationMailer.notification_mail(@blog).deliver  ##追記
      # 一覧画面へ遷移して"ブログを作成しました！"とメッセージを表示します。
      redirect_to controller: 'users', action: 'show', id:current_user.id, notice: "ブログを作成しました！"
    else
      # 入力フォームを再描画します。
      render 'new'
    end
  end
  
  def confirm
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    render :new if @blog.invalid?
  end
  
  def show
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)

  end
  
  def edit
  end
  
  def update
    if @blog.update(blog_params)
      redirect_to controller: 'users', action: 'show', id:current_user.id, notice: "ブログを編集しました！"
    else
      render 'edit'
    end
  end
  
  def destroy
    @blog.destroy
    redirect_to controller: 'users', action: 'show', id:current_user.id, notice:"ブログを削除しました！"
  end
  
  private
  
  def blog_params
    params.require(:blog).permit(:title, :content, :user_id, :image, :image_cache)
  end
  
  def set_blog
    @blog = Blog.find(params[:id])
  end
  
end