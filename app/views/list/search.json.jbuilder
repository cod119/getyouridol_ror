json.array!(@idols) do |idol|
  json.nameko       idol.nameko
  json.nameja       idol.nameja
  json.nameen       idol.nameen
  json.cv           idol.cv
end