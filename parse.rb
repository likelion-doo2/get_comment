require 'nokogiri'

1.step(3991, 10) do |i|
  doc = Nokogiri::HTML(open("result_#{i}.html"))
  doc.css("._sp_each_url").each do |x|
    puts x.attr("href") if x.attr("href").include?("naver.com")
  end
end
