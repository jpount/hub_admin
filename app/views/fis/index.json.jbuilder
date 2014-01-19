json.array!(@fis) do |fi|
  json.extract! fi, 
  json.url fi_url(fi, format: :json)
end
