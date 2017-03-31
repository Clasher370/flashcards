def open_page(page)
  Nokogiri::HTML(open(page))
end

def parse_page(page, option)
  open_page(page).xpath(option)
end

def creat_card(original, translated)
  Card.create(original_text: original, translated_text: translated)
end

def validate_words(original, translated)
  original == 'German word  ' || translated.size == 1 ? false : true
end

links = parse_page('http://www.languagedaily.com/learn-german',
                   '//*[@id="jsn-pos-mainmenu"]/div/div/div/ul/li[3]/ul/li/a/attribute::href')

links.each do |link|
  words = parse_page("http://www.languagedaily.com#{link}",
                     '//*[@id="jsn-mainbody"]/div[2]/div/div[1]/table/tbody/tr/child::td').to_a

  words.in_groups_of(4) do |_, original, translation, _|
    if validate_words(original.text, translation.text)
      creat_card(original.text, translation.text)
    end
  end
end
