1.step(3991, 10) do |i|
  puts i
  `curl -o result_#{i}.html "https://search.naver.com/search.naver?ie=utf8&where=news&query=이두희&sm=tab_pge&sort=0&photo=0&field=0&reporter_article=&pd=0&ds=&de=&docid=&mynews=0&start=#{i}&refresh_start=0"`
end
