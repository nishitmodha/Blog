class PostsController < ApplicationController
    before_action :find_post, only: [:show, :update, :edit, :destroy]
    before_action :authenticate_user!, except: [:index,:show]
    
    def index
        @posts = Post.all.order("created_at DESC")
    end
    
    def new
    @post = Post.new
    end
    
    def create
        @post = Post.new(post_params)

        if @post.save
            redirect_to @post, notice: "Post Created"
        else
            render 'new'
        end
    end

    def show
    end

    def update
        if @post.update(post_params)
            redirect_to @post, notice: "Post Updated"
        else
            render 'edit'
        end
    end

    def edit
    end

    def destroy
        @post.destroy
        
        redirect_to posts_path, notice: "Post Deleted"
    end

    private
    
    def post_params
        params.require(:post).permit(:title, :content, :user_id)
    end

    def find_post
        @post = Post.find(params[:id])
    end

end
