require 'redmine'
require 'dispatcher'

require_dependency 'meta_hook'

RAILS_DEFAULT_LOGGER.info 'Starting Meta Tags Plugin for Redmine'

Dispatcher.to_prepare :meta_plugin do
    unless ActionView::Base.included_modules.include?(MetaHelper)
        ActionView::Base.send(:include, MetaHelper)
    end
    #unless ProjectsController.included_modules.include?(MetaProjectsControllerPatch)
    #    ProjectsController.send(:include, MetaProjectsControllerPatch)
    #end
    #unless NewsController.included_modules.include?(MetaNewsControllerPatch)
    #    NewsController.send(:include, MetaNewsControllerPatch)
    #end
    #unless WikiController.included_modules.include?(MetaWikiControllerPatch)
    #    WikiController.send(:include, MetaWikiControllerPatch)
    #end
    #unless WelcomeController.included_modules.include?(MetaWelcomeControllerPatch)
    #    WelcomeController.send(:include, MetaWelcomeControllerPatch)
    #end
end

Redmine::Plugin.register :meta_plugin do
    name 'Meta tags'
    author 'Andriy Lesyuk'
    author_url 'http://www.andriylesyuk.com'
    description 'Adds an ability to specify meta description and keywords.'
    url 'http://projects.andriylesyuk.com/projects/redmine-meta'
    version '0.1.0'
end
