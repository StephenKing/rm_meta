require_dependency 'issues_controller'

module MetaIssuesControllerPatch
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
            if @issue.description.present?
                # TODO: description.scan(%r{})
                meta_description(strip_tags(textilizable(@issue.description, :project => @issue.project)).gsub(/^(.{255}[^\n\r]*).*$/m, '\1...').strip)
            end
        end

    end

end
