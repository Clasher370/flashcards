# app/mailers/cards_mailer.rb
class CardsMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def pending_cards_notification(user)
    mail(to: user.email, subject: 'Пора проверять карты!')
  end
end
