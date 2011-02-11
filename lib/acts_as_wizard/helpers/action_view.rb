module CheefChe
  module Acts
    module Wizard
      module Helpers
        module ActionView

          def wizard_buttons_for resource, &proc
            CheefChe::Acts::Wizard::Renderers::Buttons.new(self).render resource, &proc
          end

          def wizard_steps_breadcrumb resource
            CheefChe::Acts::Wizard::Renderers::Breadcrumb.new(self).render resource
          end

          def wizard_steps_info resource
            CheefChe::Acts::Wizard::Renderers::StepsInfo.new(self).render resource
          end

          def wizard_hidden_fields
            hidden_field_tag "wizard_resource_step", session["wizard_resource_step"]
          end

          def wizard_step_title
            @wizard_step_title ||= @wizard_resource.current_step.title || default_wizard_step_title
          end

          def default_wizard_step_title
            "#{@wizard_resource.current_step.name} step".camelize.html_safe  
          end

        end
      end
    end
  end
end