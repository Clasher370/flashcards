class SendNotificationMailToUser
  def self.run
    User.find(Card.with_ready_date.map{|c| c.user_id}.uniq).each do |user|
      CardsMailer.pending_cards_notification(user).deliver_now
    end
  end
end
