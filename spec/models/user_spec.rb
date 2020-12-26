require 'rails_helper'

RSpec.describe User, type: :model do
  it 'create a valid user' do
    user = create(:user)
    expect(user).to be_valid
  end

  context 'Validations' do  
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
  end
end
