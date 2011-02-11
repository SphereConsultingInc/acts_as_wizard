module CheefChe
  module Acts
    module Wizard
      module Models
        module ActiveRecord
          extend ActiveSupport::Concern

          module ClassMethods
            def acts_as_wizard &proc
              include CheefChe::Acts::Wizard::Models::Base
              proc.call CheefChe::Acts::Wizard::Models::Master.new(self)
            end
          end

          module InstanceMethods
            def wizard_running?
              respond_to?(:step?) && @current_step.nil?
            end

            def wizard_running_with_step? step_name
              wizard_running? && step?(step_name)
            end
          end

        end
      end
    end
  end
end