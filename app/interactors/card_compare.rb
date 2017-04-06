class CardCompare
  def initialize(original_text, user_text)
    @original_text = original_text
    @user_text = user_text
  end

  def compare
    compare_text(@original_text, @user_text)
  end

  private

  def compare_text(text_one, text_two)
    true if text_one.downcase == text_two.downcase
  end
end
