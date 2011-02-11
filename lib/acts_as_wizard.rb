module CheefChe
  module Acts
    module Wizard

      module Models
        autoload :ActiveRecord, 'acts_as_wizard/models/active_record'
        autoload :Base,         'acts_as_wizard/models/base'
        autoload :Master,       'acts_as_wizard/models/master'
        autoload :Step,         'acts_as_wizard/models/step'
      end

      module Controllers
        autoload :ActionController, 'acts_as_wizard/controllers/action_controller'
        autoload :Base,             'acts_as_wizard/controllers/base'
      end

      module Renderers
        autoload :Base,        'acts_as_wizard/renderers/base'
        autoload :Breadcrumb,  'acts_as_wizard/renderers/breadcrumb'
        autoload :Buttons,     'acts_as_wizard/renderers/buttons'
        autoload :StepsInfo,   'acts_as_wizard/renderers/steps_info'
      end

      module Helpers
        autoload :ActionView, 'acts_as_wizard/helpers/action_view'
      end

    end
  end
end

require 'acts_as_wizard/railtie'