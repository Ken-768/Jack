class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def likes
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id)
  end

  def show
    @user = User.find(params[:id])
    @users = User.all
    @articles = Article.where(user_id: @user.id)
    @allArticles = Article.all
  end

  def edit
    @user = User.find(params[:id])
  end

 
  def create
    if @user.save
      flash[:notice] = "登録に成功しました"
  else
      flash[:alert] = "登録に失敗しました"
    end
  end

  def update
    
      if current_user == @user
        if @user.update(user_params)
          flash[:success] = 'ユーザー情報を編集しました。'
          render :edit
          else
          flash.now[:danger] = 'ユーザー情報の編集に失敗しました。'
          render :edit
        end
      else
        redirect_to root_url
      end
  end
  
end