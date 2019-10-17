class ArticlesController < ApplicationController

    before_action :authenticate_user!, except: [:search, :show]

    

    def new
        @article = Article.new
    end

    def search
        if params[:search] == nil
            @search = Article.includes(:user)
        elsif params[:search] == ""
            @search = Article.includes(:user)
        else
            @search = Article.includes(:user).where("title LIKE ? ",'%' + params[:search] + '%').or(Article.where("place LIKE ? ", "%" + params[:search] + "%"))
        end
    end

    def create
        @article = current_user.articles.create(article_params)
        user = User.find(@article.user_id)
        if @article.save
            flash[:info] = "新規投稿しました"
            redirect_to(user)
        else
            flash[:alert] = "投稿に失敗しました"
            redirect_to action:"new"
        end
    end

    def show
        @article = Article.find(params[:id])
        @like = Like.new
        @comments = @article.comments
        @comment = Comment.new
    end

    def edit
        @article = Article.find(params[:id])
    end

    def update
        article = Article.find(params[:id])
        article.update(article_params)
        redirect_to article
    end

    def destroy
        article = Article.find(params[:id])
        article.delete
        user = User.find(article.user_id)

        redirect_to(user)
    end

    private
    def article_params
        params.require(:article).permit(:title, :place, :content)
    end
end
