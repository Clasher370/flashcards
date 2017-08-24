# app/mailers/send_notification_mail_to_user.rb
class SendNotificationMailToUser
  def self.run
    User.find(Card.with_ready_date.pluck(:user_id).uniq).each do |user|
      CardsMailer.pending_cards_notification(user).deliver_now
    end
  end
end
