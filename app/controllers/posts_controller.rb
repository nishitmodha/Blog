class PostsController < ApplicationController
    before_action :find_post, only: [:show, :update, :edit, :destroy]
    before_action :authenticate_user!, except: [:index,:show]
    before_action :correct_user, only: [:edit, :update, :destroy]
    
    def index
        @posts = Post.all.order("created_at DESC")
    end
    
    def new
    # @post = Post.new
    @post = current_user.posts.build
    end
    
    def create
        #@post = Post.new(post_params)
        @post = current_user.posts.build(post_params)

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
        @comment = @post.comments.where(post_id: @post.id) 
        @comment.each do |comment|
            comment.destroy
        end
        
        redirect_to posts_path, notice: "Post Deleted"
    end

    def correct_user
        @post = current_user.posts.find_by(id: params[:id])
        redirect_to posts_path, notice: "Not Authorised to edit this post" if @post.nil?
    end

    def myposts
        @posts = current_user.posts.all
    end

    private
    
    def post_params
        params.require(:post).permit(:title, :content, :user_id)
    end

    def find_post
        @post = Post.find(params[:id])
    end

end
