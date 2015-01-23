class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @topic = @post.topic
    @comment = current_user.comments.build(params.require(:comment).permit(:body))
    if @comment.save
       flash[:notice] = "comment was saved."
      redirect_to topic_post_path(@topic, @post)
     else
      flash[:error] = "There was an error saving the comment. Please try again."
     end
  end
  
  def destroy
     @post = Post.find(params[:post_id])
     @topic = @post.topic
     @comment = @post.comments.find(params[:id])
     authorize @comment
     if @comment.destroy
       flash[:notice] = "Comment was removed."
       redirect_to topic_post_path(@topic, @post)
     else
       flash[:error] = "Comment couldn't be deleted. Try again."
       redirect_to topic_post_path(@topic, @post)
     end
   end
end
