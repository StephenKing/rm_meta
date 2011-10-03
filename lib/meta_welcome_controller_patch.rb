require_dependency 'welcome_controller'

# FIXME: view_welcome_index_left or view_welcome_index_right

module MetaWelcomeControllerPatch
    include ApplicationHelper
    include ActionView::Helpers::SanitizeHelper

    def self.included(base)
        base.extend(ClassMethods)
        base.extend(ActionView::Helpers::SanitizeHelper::ClassMethods)
        base.send(:include, InstanceMethods)
        base.class_eval do
            unloadable
            before_filter :set_meta_description, :only => :index
        end
    end

    module ClassMethods
    end

    module InstanceMethods

        def set_meta_description
            if Setting.welcome_text.present?
                meta_description(strip_tags(textilizable(Setting.welcome_text)).gsub(/^(.{255}[^\n\r]*).*$/m, '\1...').strip)
            end
        end

    end

end
