require_dependency 'welcome_controller'

module MetaWelcomeControllerPatch
    include ApplicationHelper

    def self.included(base)
        base.extend(ClassMethods)
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
             meta_description(Setting.welcome_text.gsub(/^(.{255}[^\n\r]*).*$/m, '\1...').strip) if Setting.welcome_text.present?
        end

    end

end
