module CheefChe
  module Acts
    module Wizard
      module Controllers
        module Base
          extend ActiveSupport::Concern

          included do
            include ActiveSupport::Callbacks
            class_attribute :wizard_resource_class
            before_filter :load_wizard_resource, :only => [:new, :create]
            define_callbacks :load_wizard_resource
            define_callbacks :load_wizard_step
            define_callbacks :leave_wizard
            define_callbacks :previous_step
            define_callbacks :next_step
          end

          module InstanceMethods

            def new
              load_wizard_step_from_url
            end

            def create
              load_wizard_step
              @wizard_resource.attributes = params[self.class.wizard_resource_class.to_s.underscore.to_sym]

              if @wizard_resource.save :validate => needs_step_validation?

                if @wizard_resource.leave_step? && pushed_leave?
                  leave_wizard!
                else
                  pushed_back? ? previous_step! : next_step!
                end

              else
                get_back!
              end

            end

            protected

              def leave_wizard!
                run_callbacks :leave_wizard do
                  clear_wizard_session_variables
                  redirect_to seller_product_path(current_seller, @wizard_resource), :notice => "#{@wizard_resource.class.to_s.humanize} was successfully created."
                end                 
              end

              def get_back!
                remember_step
                render "new"
              end

              def needs_step_validation?
                !pushed_back?
              end

              def previous_step!
                run_callbacks :previous_step do
                  step = @wizard_resource.previous_step!
                  remember_step
                  redirect_to :action => :new, :step => step.name
                end
              end

              def next_step!
                run_callbacks :next_step do
                  step = @wizard_resource.next_step!
                  remember_step
                  redirect_to :action => :new, :step => step.name
                end
              end

              def load_wizard_step
                run_callbacks :load_wizard_step do
                  step = self.class.wizard_resource_class.find_or_initialize_step_by_name(session["wizard_resource_step"])
                  @wizard_resource.current_step = step unless step.blank?
                  @wizard_resource.completed_step_names = session["wizard_completed_step_names"]  || []
                end                
              end

              def load_wizard_step_from_url
                run_callbacks :load_wizard_step do
                  step = get_wizard_step_from_url || self.class.wizard_resource_class.find_or_initialize_step_by_name(session["wizard_resource_step"])
                  @wizard_resource.current_step = step unless step.blank?
                  @wizard_resource.completed_step_names = session["wizard_completed_step_names"]  || []
                end
              end

              def get_wizard_step_from_url
                step_name = get_wizard_step_name_from_url
                return if step_name.blank?

                step = self.class.wizard_resource_class.find_step_by_name(step_name)
                return if step.blank?

                if step_name == session["wizard_resource_step"] || session["wizard_completed_step_names"].include?(step_name)
                  step
                else
                  nil
                end
              end

              def get_wizard_step_name_from_url
                params[:step] if !params[:step].blank? && @wizard_resource.class.steps.map(&:name).include?(params[:step].to_sym)
              end

              def load_wizard_resource
                run_callbacks :load_wizard_resource do
                  if @wizard_resource.blank?
                    @wizard_resource   = self.class.wizard_resource_class.find(session["wizard_resource_id"]) if session["wizard_resource_id"]
                    @wizard_resource ||= self.class.wizard_resource_class.new
                  end
                end
              end

              def remember_step
                session["wizard_resource_id"]        ||= @wizard_resource.id
                session["wizard_resource_step"]        = @wizard_resource.current_step.name
                session["wizard_completed_step_names"] = @wizard_resource.completed_step_names
              end              

              def clear_wizard_session_variables
                %w{ wizard_completed_step_names wizard_resource_step wizard_resource_id }.each { |name| session[name] = nil }
              end

              def pushed_back?
                params[:back_button]
              end

              def pushed_leave?
                params[:leave_button]
              end

          end
        end
      end
    end
  end
end