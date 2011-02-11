module CheefChe
  module Acts
    module Wizard
      module Renderers
        class Base

          def initialize context
            @context = context
          end
  
          def render resource
            @resource = resource
          end

          protected

            def method_missing method, *args, &block
              @context.send method, *args, &block
            end

            def current_step_name
              session[:wizard_resource_step]
            end

            def step_number step_name
              number = steps.map(&:name).index(step_name)
              number += 1 unless number.nil?
              number
            end

            def steps
              @resource.class.steps
            end

        end
      end
    end
  end
end