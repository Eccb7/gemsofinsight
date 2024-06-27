json.extract! admin_post, :id, :title, :content, :gem_blog_category_id, :created_at, :updated_at
json.url admin_post_url(admin_post, format: :json)
