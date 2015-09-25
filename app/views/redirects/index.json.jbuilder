json.array!(@redirects) do |redirect|
  json.extract! redirect, :id, :source, :target, :changedby, :published
  json.url redirect_url(redirect, format: :json)
end
