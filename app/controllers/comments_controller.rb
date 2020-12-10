class CommentsController < ApplicationController
    before_action :authenticate_user!

    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.create(params[:comment].permit(:name, :comment))
        redirect_to post_path(@post), notice: "Comment Created"
    end


    def destroy
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        @comment.destroy
        redirect_to post_path(@post), notice: "Comment Deleted"
    end 
end



