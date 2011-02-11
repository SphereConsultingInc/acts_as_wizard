module CheefChe
  module Acts
    module Wizard
      module Renderers
        class Breadcrumb < Base

          def render resource
            super
            with_wrapper steps.map{ |step| render_step step }.join(separator).html_safe
          end

          protected
  
            def with_wrapper html
              content_tag :div, :class => 'l-wizard-breadcrumb' do
                content_tag :ul, html, :class => 'b-wizard-breadcrumb clearfix'
              end
            end

            def render_step step
              content_tag :li, :class => step_classes(step) do
                html =  content_tag :span, step_number(step.try(:name)), :class => 'b-wizard-step-number'
                html << content_tag(:span, step.try(:name),              :class => 'b-wizard-step-name')
                html
              end
            end

            def step_classes step
              html_classes = []
              html_classes << 'current'   if step.try(:name) === current_step_name
              html_classes << 'completed' if step.try(:name) && @resource.completed_step_names.include?(step.try(:name))
              html_classes.join ' '
              html_classes.blank? ? nil : html_classes
            end

            def separator; ''; end

        end
      end
    end
  end
end