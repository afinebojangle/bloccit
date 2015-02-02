class CommentsController < ApplicationController
  
  respond_to :html, :js
  
  def create
    @post = Post.find(params[:post_id])
    @topic = @post.topic
    @comment = current_user.comments.build(params.require(:comment).permit(:body))
    @comment.post = @post
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
     else
       flash[:error] = "Comment couldn't be deleted. Try again."
     end
     
     respond_with(@comment) do |format|
       format.html { redirect_to [@post.topic, @post] }
     end
   end
end
