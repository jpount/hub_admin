json.array!(@confs) do |conf|
  json.extract! conf, 
  json.url conf_url(conf, format: :json)
end
