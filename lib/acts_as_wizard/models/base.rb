module CheefChe
  module Acts
    module Wizard
      module Models
        module Base

          extend ActiveSupport::Concern

          included do
            class_attribute :steps
            attr_writer :current_step
            attr_writer :completed_step_names
          end

          module ClassMethods

            def find_or_initialize_step_by_name name
               find_step_by_name(name) || steps.first
            end

            def find_step_by_name name
              steps.detect { |s| s.name == name } unless name.blank?
            end

          end

          module InstanceMethods

            def current_step
              @current_step || self.class.steps.first
            end

            def step? name
              current_step.try(:name) === name
            end

            def previous_step!
              self.current_step = self.class.steps[self.class.steps.index(current_step) - 1]
            end

            def next_step!
              self.completed_step_names = [] if completed_step_names.empty?
              self.completed_step_names << current_step.try(:name)
              self.current_step = self.class.steps[self.class.steps.index(current_step) + 1]
            end

            def first_step?
              self.current_step === self.class.steps.first
            end

            def last_step?
              self.current_step === self.class.steps.last
            end

            def leave_step?
              last_step? || current_step.leave?
            end

            def completed_step_names
              @completed_step_names || []
            end

          end
        end
      end
    end
  end
end