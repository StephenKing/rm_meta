require_dependency 'wiki_controller'

module MetaWikiControllerPatch
    include ApplicationHelper
    #include ActionView::Helpers::SanitizeHelper
    #include ActionView::Helpers::UrlHelper

    def self.included(base)
        base.extend(ClassMethods)
        #base.extend(ActionView::Helpers::SanitizeHelper::ClassMethods)
        base.send(:include, InstanceMethods)
        base.class_eval do
            unloadable
            before_filter :set_meta_description, :only => [ :index, :show ]
        end
    end

    module ClassMethods
    end

    module InstanceMethods

        def set_meta_description
            #@page = @wiki.find_page(params[:page])
            #if @page && @page.content && @page.content.text.present?
                # FIXME
                #meta_description(strip_tags(textilizable(@page.content.text, :project => @wiki.project)).gsub(/^(.{255}[^\n\r]*).*$/m, '\1...').strip)
            #end
        end

    end

end
