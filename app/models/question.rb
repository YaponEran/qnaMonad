# frozen_string_literal: true

class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :user
  has_many :votes, as: :votable, dependent: :destroy
end
