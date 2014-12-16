class Post < ActiveRecord::Base
  has_many :comments


  def title
  end
end
