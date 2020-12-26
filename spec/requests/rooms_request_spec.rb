require 'rails_helper'

RSpec.describe 'Rooms', type: :request do
  it 'GET /rooms' do
    user = create(:user)
    sign_in user
    get rooms_path
    expect(response).to have_http_status(:success)
  end

  it 'GET /rooms/new' do
    user = create(:user)
    sign_in user
    get new_room_path
    expect(response).to have_http_status(:success)
  end

  it 'GET /rooms/edit/:id' do
    user = create(:user)
    room = create(:room)
    sign_in user
    get edit_room_path(room.id)
    expect(response).to have_http_status(:success)
  end

end
