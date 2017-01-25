class Comment < ApplicationRecord
  belongs_to :article
  validates :username, presence: true
  validates :body, presence: true, length: {minimum: 5}


end
