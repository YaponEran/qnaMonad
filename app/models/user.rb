class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :votes, dependent: :destroy
  # has_one_attached :avatar

  COUNTRIES = [
    "Kazakhstan",
    "Turkmenistan",
    "Russia",
    "USA"
  ]

  def self.add_country
    COUNTRIES.each do |c|
      country = c
    end
  end

  def author_of?(item)
    item.user_id == id
  end
end
