require 'rails_helper'

RSpec.describe Room, type: :model do
  it 'create a valid room' do
    room = create(:room)
    expect(room).to be_valid
  end
end
