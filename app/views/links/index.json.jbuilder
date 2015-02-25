json.array!(@links) do |link|
  json.extract! link, :id, :path, :whitelist, :blacklist, :unreachable
  json.url link_url(link, format: :json)
end
