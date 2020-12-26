# frozen_string_literal: true

class Layout::Navbar::Component < ViewComponent::Base
  def initialize(user: nil)
    @user = user
  end
end
