require 'csv'
media_file = Rails.root.join('db', 'media_seeds.csv')

CSV.foreach(media_file, headers: true, header_converters: :symbol, converters: :all) do |row|
  data = Hash[row.headers.zip(row.fields)]
  puts data
  Work.create!(data)
end
