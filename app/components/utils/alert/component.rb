# frozen_string_literal: true

class Utils::Alert::Component < ViewComponent::Base
  def initialize(message: '', type: '')
    @message = message
    @type = type
  end

  def change_bg_color(type)
    case type
    when 'success'
      'alert-success'
    when 'warning'
      'alert-warning'
    when 'error'
      'alert-danger'
    end
  end

  def render?
    !@message.empty? && !@type.empty?
  end
end
