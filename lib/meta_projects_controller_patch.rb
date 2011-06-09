require_dependency 'projects_controller'

module MetaProjectsControllerPatch
    include ApplicationHelper

    def self.included(base)
        base.extend(ClassMethods)
        base.send(:include, InstanceMethods)
        base.class_eval do
            unloadable
            before_filter :set_meta_description, :only => :show
        end
    end

    module ClassMethods
    end

    module InstanceMethods

        def set_meta_description
            meta_description(@project.short_description) if @project && @project.description.present?
        end

    end

end
