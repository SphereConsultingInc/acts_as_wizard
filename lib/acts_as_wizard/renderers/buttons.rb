module CheefChe
  module Acts
    module Wizard
      module Renderers
        class Buttons

          def initialize context
            @context = context
          end

          def render resource, &proc
            @resource = resource

            capture do
              proc.call self
            end

          end

          def back text = 'Back', html_options = {}
            submit_tag(text, html_options.merge(:name => 'back_button')) unless @resource.first_step?
          end

          def finish text = 'Finish', html_options = {}
            submit_tag(text, html_options.merge(:name => 'leave_button')) if @resource.leave_step?
          end

          def continue text = 'Continue', html_options = {}
            submit_tag(text, html_options.merge(:name => 'continue_button')) unless @resource.last_step?
          end

          protected

            def method_missing method, *args, &block
              @context.send method, *args, &block
            end

        end
      end
    end
  end
end