require 'redmine'
require 'dispatcher'

RAILS_DEFAULT_LOGGER.info 'Starting Meta Tags Plugin for Redmine'

Dispatcher.to_prepare :meta_plugin do
    unless ApplicationHelper.included_modules.include?(MetaApplicationHelperPatch)
        ApplicationHelper.send(:include, MetaApplicationHelperPatch)
    end
    unless ProjectsController.included_modules.include?(MetaProjectsControllerPatch)
        ProjectsController.send(:include, MetaProjectsControllerPatch)
    end
    unless NewsController.included_modules.include?(MetaNewsControllerPatch)
        NewsController.send(:include, MetaNewsControllerPatch)
    end
    unless WikiController.included_modules.include?(MetaWikiControllerPatch)
        WikiController.send(:include, MetaWikiControllerPatch)
    end
    unless WelcomeController.included_modules.include?(MetaWelcomeControllerPatch)
        WelcomeController.send(:include, MetaWelcomeControllerPatch)
    end
end

# FIXME: maybe rewrite base.rhtml

Redmine::Plugin.register :meta_plugin do
    name 'Meta tags'
    author 'Andriy Lesyuk'
    author_url 'http://www.andriylesyuk.com'
    description 'Adds an ability to specify meta description and keywords.'
    url 'http://projects.andriylesyuk.com/projects/redmine-meta'
    version '0.0.2'
end
