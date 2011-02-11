module CheefChe
  module Acts
    module Wizard
      module Models
        class Master

          def initialize context
            @context = context
          end

          def step name, *options
            @context.steps ||= []
            @context.steps << Step.new(name, *options)
            @context.steps.compact
          end

        end
      end
    end
  end
end

