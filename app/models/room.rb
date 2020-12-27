# frozen_string_literal: true

class Room < ApplicationRecord
  has_many :schedules, class_name: 'Schedule', dependent: :destroy
  validates :name, presence: true
end
