class User < ApplicationRecord
  has_many :cards

  authenticates_with_sorcery!
end
