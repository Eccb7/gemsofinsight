class Post < ApplicationRecord
  belongs_to :gem_blog_category
  
  has_rich_text :content
end
