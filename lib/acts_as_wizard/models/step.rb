module CheefChe
  module Acts
    module Wizard
      module Models
        class Step

          attr_reader :name, :options

          def initialize name, options = {}
            @name, @options = name, options
            nil unless should_initialized?
          end

          def leave?
            options[:leave] ? true : false
          end

          def title
            options[:title]
          end

          protected

            def should_initialized?
              return true if options[:if].blank?

              case options[:if]
                when Proc
                  options[:if].call
                when Symbol
              end
            end

        end
      end
    end
  end
end