class CommentsController < ApplicationController
  def create
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id]) 
    @comment = current_user.comments.build(params.require(:comment).permit(:body))
    if @comment.save
       flash[:notice] = "comment was saved."
       redirect_to [@topic, @post]
     else
      flash[:error] = "There was an error saving the comment. Please try again."
     end
  end
end
