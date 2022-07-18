require 'uri'
require 'net/http'
require 'json'
require 'nokogiri'

User.create(name: 'Guest', password: 'password', password_confirmation: 'password')

url = URI('https://www.gsi.go.jp/kihonjohochousa/kihonjohochousa41140.html')

https = Net::HTTP.new(url.host, url.port)
https.use_ssl = true

request = Net::HTTP::Get.new(url)
response = https.request(request)
doc = Nokogiri::HTML(response.read_body)
doc.css('tr').each do |tr|
  mountain = Mountain.new
  tr.css('td').each_with_index do |td, index|
    case index
    when 0
      # name: hiragana, kanji
      mountain.name = td.content.split(nil)[1]
      mountain.ruby = td.content.split(nil)[0]
    when 1
      mountain.prefecture = td.content # prefecture
    when 2
      mountain.location = td.content # location(detail)
    when 3
      mountain.height = td.content # height
    when 4
      # latitude, longtitude
      mountain.latitude = td.content.split(nil)[0].gsub('度', '.').gsub('分', '').gsub('秒', '').to_f
      mountain.longtitude = td.content.split(nil)[1].gsub('度', '.').gsub('分', '').gsub('秒', '').to_f
    end
  end
  mountain.save if mountain.name
end
