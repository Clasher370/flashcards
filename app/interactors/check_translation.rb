class CheckTranslation
  include Interactor

  def call
    check_card = CardCompare.new(context.original_text, context.user_text)
    if check_card.compare
      context.card = context.id
    else
      context.fail!
    end
  end
end