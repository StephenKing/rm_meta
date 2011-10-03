require_dependency 'projects_controller'

# FIXME: view_projects_show_left, view_projects_show_right or view_projects_show_sidebar_bottom

module MetaProjectsControllerPatch
    include ApplicationHelper
    include ActionView::Helpers::SanitizeHelper

    def self.included(base)
        base.extend(ClassMethods)
        base.extend(ActionView::Helpers::SanitizeHelper::ClassMethods)
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
            if @project && @project.description.present?
                meta_description(strip_tags(textilizable(@project.short_description, :project => @project)))
            end
        end

    end

end
