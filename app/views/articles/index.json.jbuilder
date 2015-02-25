json.array!(@articles) do |article|
  json.extract! article, :id, :title, :desc, :content, :img, :url
  json.url article_url(article, format: :json)
end
