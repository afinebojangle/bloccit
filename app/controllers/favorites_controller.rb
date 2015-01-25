class FavoritesController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.build(post: @post)
    authorize favorite
    if favorite.save
       flash[:notice] = "Favorited!"
       redirect_to [@post.topic, @post]
    else
      flash[:error] = "There was an error favoriting the post. Please try again."
        redirect_to @post
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by_post_id(@post.id)
    authorize favorite
    if favorite.destroy
     flash[:notice] = "Un-Favorited."
     redirect_to [@post.topic, @post]
    else
     flash[:notice] = "There was an error un-favoriting. Try again later."
     redirect_to @post
    end
  end

end
