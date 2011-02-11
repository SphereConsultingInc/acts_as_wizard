module CheefChe
  module Acts
    module Wizard
      module Controllers
        module ActionController
          extend ActiveSupport::Concern

          module ClassMethods

            def wizard_for resource_name, &proc
              include CheefChe::Acts::Wizard::Controllers::Base

              self.wizard_resource_class = resource_name.to_s.camelize.constantize

              if defined? wizard_resource_class
                wizard_resource_class.acts_as_wizard &proc
              end
            end

          end

        end
      end
    end
  end
end