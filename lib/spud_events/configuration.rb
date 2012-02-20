module Spud
  module Events
    include ActiveSupport::Configurable

    config_accessor :base_layout, :content_for, :calendar_layout
    self.base_layout = "application" 
    self.content_for = nil
    self.calendar_layout = nil
  end
end