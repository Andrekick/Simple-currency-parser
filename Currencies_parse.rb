#encoding: UTF-8
require 'nokogiri'
require 'httparty'
require 'byebug'

if (Gem.win_platform?)
Encoding.default_external = Encoding.find(Encoding.locale_charmap)
Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

def parser
  url = "https://smart-lab.ru/"
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page.body)
  #links = parsed_page.css('a.news_item__title').map { |link| link['href'] }
  doc = parsed_page.css('table.trade')
  puts "Getting info on currencies and stocks"
  # sleep 2
  usd = doc.css('td')[3..4].text
  usd_change = doc.css('td')[5].text
  eur = doc.css('td')[6..7].text
  # btc = doc.css('td')[64].text
  puts "#{usd}, changed by #{usd_change}"
  puts eur
  # puts "BTC = #{btc}"

  # Парсинг блока новостей справа --- parsed_page.css('div.tab')[1].text.gsub(/\s+\t/, "")
  # doc.css('tr:nth-child(2n+1)').each do |tr_node| end -- going through rows
  # doc.css('tr:nth-child(10)').text rows text

end

def parser_btc
  url = "https://coinmarketcap.com/"
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page.body)
  btc = parsed_page.css('td').each do |td|
  end
  btc_price = btc.map { |num| num.text}
  puts "BTC price is #{btc_price[3]}"
  #byebug
 end

parser
parser_btc
