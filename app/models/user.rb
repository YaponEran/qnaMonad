class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

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
end
