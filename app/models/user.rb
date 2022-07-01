class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

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
