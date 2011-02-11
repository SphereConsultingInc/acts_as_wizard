module CheefChe
  module Acts
    module Wizard
      module Renderers
        class StepsInfo < Base

          def render resource
            super
            content_tag :span, "Step #{current_step_number} of #{total_steps}", :class => 'b-wizard-steps-info'
          end

          protected

            def current_step_number
              step_number current_step_name
            end

            def total_steps
              steps.length
            end

        end
      end
    end
  end
end