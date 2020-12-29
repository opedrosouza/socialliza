class Schedule < ApplicationRecord
  belongs_to :user
  belongs_to :room

  scope :starts, ->(start_date){ where(starts_at: start_date) }
  scope :of_room, ->(room_id){ where(room: room_id) }

  def self.valid_date(room_id, date)
    if Schedule.of_room(room_id).starts(date).count > 0
      errors.add :exists, :invalid, message: 'Horário já reservado'
    else
      true
    end
  end
end
