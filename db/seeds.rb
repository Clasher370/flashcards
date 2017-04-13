def open_page(page)
  Nokogiri::HTML(open(page))
end

def parse_page(page, option)
  open_page(page).xpath(option)
end

def creat_card(user, original, translated)
  user.cards.create(original_text: original, translated_text: translated)
end

user = User.create(email: 'login', password: 'secret', password_confirmation: 'secret')

links = parse_page('http://www.languagedaily.com/learn-german',
                   '//*[@id="jsn-pos-mainmenu"]/div/div/div/ul/li[3]/ul/li/a/attribute::href')

links.each do |link|
  words = parse_page("http://www.languagedaily.com#{link}",
                     '//*[@id="jsn-mainbody"]/div[2]/div/div[1]/table/tbody/tr/child::td').to_a

  words.in_groups_of(4) do |_, original, translation, _|
    if original.text != 'German word  '
      creat_card(user, original.text, translation.text)
    end
  end
end

user.cards.each do |card|
  card.update(review_date: Date.yesterday)
end
