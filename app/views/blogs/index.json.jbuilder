json.array!(@blogs) do |blog|
  json.extract! blog, :id, :domain, :depth
  json.url blog_url(blog, format: :json)
end
