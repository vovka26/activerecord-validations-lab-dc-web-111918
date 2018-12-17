class Post < ActiveRecord::Base
  include ActiveModel::Validations
  validates :title, presence: true
  validates :content, length: {minimum: 250}
  validates :summary, length: {maximum: 250}
  validates :category, inclusion: {in: ['Fiction', 'Non-Fiction']}
  validate :is_clickbait?

  def is_clickbait?
    clickbaits = [/Won't Believe/i, /Secret/i, /Top [0-9]*/i, /Guess/i]

    if clickbaits.none? {|bait| bait.match title}
      errors.add(:title, 'must be clickbait')
    end
  end
end
