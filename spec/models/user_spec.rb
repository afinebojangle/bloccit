require 'rails_helper'

describe User do

  include TestFactories

  describe "#favorited(post)" do
    before do
      @post = associated_post
      @user = authenticated_user      
    end
    
    it "returns `nil` if the user has not favorited the post" do
      expect( @post.favorites.where(post_id: @post.id).first ).to eq(nil)
    end

    it "returns the appropriate favorite if it exists" do
      @user.favorites.where(post: @post).create
      expect( @post.favorites.where(post_id: @post.id).first ).not_to eq(nil)
    end
  end
end