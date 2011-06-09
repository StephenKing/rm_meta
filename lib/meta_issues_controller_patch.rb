require_dependency 'issues_controller'

module MetaIssuesControllerPatch
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
            meta_description(@issue.description.gsub(/^(.{255}[^\n\r]*).*$/m, '\1...').strip) if @issue.description.present?
        end

    end

end
