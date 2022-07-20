# frozen_string_literal: true

class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :user
  has_many :votes, as: :votable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many_attached :images

  validates :images, attached: true, content_type: [:png, :jpg, :jpeg]
end
