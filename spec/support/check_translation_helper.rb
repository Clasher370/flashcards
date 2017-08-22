def expect_review_date_eq(card, time)
  expect(card.review_date.strftime('%d.%m.%Y% %H:%M')).to eq time.strftime('%d.%m.%Y% %H:%M')
end
