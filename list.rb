require 'uri'
require 'cgi'
require 'json'
require 'net/http'

news_list = %w[
http://news.naver.com/main/read.nhn?mode=LSD&mid=sec&sid1=004&oid=366&aid=0000314207
http://news.naver.com/main/read.nhn?mode=LSD&mid=sec&sid1=106&oid=057&aid=0000898101
http://news.naver.com/main/read.nhn?mode=LSD&mid=sec&sid1=106&oid=057&aid=0000898056
http://news.naver.com/main/read.nhn?mode=LSD&mid=sec&sid1=106&oid=215&aid=0000422549
http://news.naver.com/main/read.nhn?mode=LSD&mid=sec&sid1=106&oid=030&aid=0002440320
]
news_list.each do |n|
  original_url = CGI::parse(n)
  oid = original_url["oid"].first
  aid = original_url["aid"].first

  referer_url = "http://entertain.naver.com/read?oid=#{oid}&aid=#{aid}"
  comment_url = "https://apis.naver.com/commentBox/cbox5/web_naver_list_jsonp.json?ticket=news&templateId=view_ent&_callback=window.__cbox_jindo_callback._3190&lang=ko&country=KR&objectId=news#{oid}%2C#{aid}&categoryId=&pageSize=10&indexSize=10&groupId=&page=1&initialize=true&useAltSort=true&replyPageSize=100&moveTo=&sort=&userType="

  parsed_uri = URI(comment_url)
  req = Net::HTTP::Get.new(parsed_uri)
  req['Referer'] = referer_url
  res = Net::HTTP.start(parsed_uri.hostname, parsed_uri.port, :use_ssl => parsed_uri.scheme == 'https') {|http|
    http.request(req)
  }

  reformed = res.body.gsub(/\r/,"").gsub(/\n/,"")[/{.+}/]
  j = JSON.parse(reformed)
  j["result"]["commentList"].each do |c| 
    puts "#{c['userName']}, #{c['contents']}"
  end
end

