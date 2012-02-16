module Spud
  module Events
    include ActiveSupport::Configurable

    config_accessor :base_layout, :content_for
    self.base_layout = "application" 
    self.content_for = nil
  end
end