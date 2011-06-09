require_dependency 'wiki_controller'

module MetaWikiControllerPatch
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
            @page = @wiki.find_page(params[:page])
            if @page && @page.content && @page.content.text.present?
                meta_description(@page.content.text.gsub(/^(.{255}[^\n\r]*).*$/m, '\1...').strip)
            end
        end

    end

end
