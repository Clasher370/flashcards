page = Nokogiri::HTML(open("http://www.languagedaily.com/learn-german"))
all_links = page.xpath('//*[@id="jsn-pos-mainmenu"]/div/div/div/ul/li[3]/ul/li/a/attribute::href')
all_links.each do |link|
  pages = Nokogiri::HTML(open("http://www.languagedaily.com#{link}"))
  words = pages.xpath('//*[@id="jsn-mainbody"]/div[2]/div/div[1]/table/tbody/tr/child::td[2]
                      |//*[@id="jsn-mainbody"]/div[2]/div/div[1]/table/tbody/tr/child::td[3]')
  a = words.map(&:text)
  a.each_with_index do |e, i|
    if i.even? && a[i + 1].size != 1 && e != 'German word  ' && e.downcase != a[i + 1].downcase
      Card.create!(original_text: e.to_s, translated_text: a[i + 1].to_s)
    end
  end
end