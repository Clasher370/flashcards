def expect_time_eq(model_, time)
  expect(card.review_date.strftime('%d.%m.%Y% %H:%M')).to eq time.strftime('%d.%m.%Y% %H:%M')
end
