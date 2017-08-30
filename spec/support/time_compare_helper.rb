def expect_time_eq(model_data, time)
  expect(model_data.strftime('%d.%m.%Y% %H:%M')).to eq time.strftime('%d.%m.%Y% %H:%M')
end
