require_dependency 'news_controller'

# FIXME: view_layouts_base_content or view_layouts_base_body_bottom

module MetaNewsControllerPatch
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
            meta_description(@news.summary) if @news && @news.summary.present?
        end

    end

end
