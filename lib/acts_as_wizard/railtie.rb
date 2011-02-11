require 'rails'

module CheefChe
  module Acts
    module Wizard
      class Railtie < ::Rails::Railtie
        config.before_initialize do
          ActiveSupport.on_load :active_record do
            ActiveRecord::Base.send :include, CheefChe::Acts::Wizard::Models::ActiveRecord
          end

          ActiveSupport.on_load :action_view do
            ActionView::Base.send :include, CheefChe::Acts::Wizard::Helpers::ActionView
          end

          ActiveSupport.on_load :action_controller do
            ActionController::Base.send :include, CheefChe::Acts::Wizard::Controllers::ActionController
          end
        end
      end
    end
  end
end
