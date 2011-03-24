require 'redmine'
require 'dispatcher'

RAILS_DEFAULT_LOGGER.info 'Starting Meta Tags Plugin for Redmine'

Dispatcher.to_prepare :meta_plugin do
    unless ApplicationHelper.included_modules.include?(ApplicationHelperPatch)
        ApplicationHelper.send(:include, ApplicationHelperPatch)
    end
    unless ProjectsController.included_modules.include?(ProjectsControllerPatch)
        ProjectsController.send(:include, ProjectsControllerPatch)
    end
    unless NewsController.included_modules.include?(NewsControllerPatch)
        NewsController.send(:include, NewsControllerPatch)
    end
    unless WikiController.included_modules.include?(WikiControllerPatch)
        WikiController.send(:include, WikiControllerPatch)
    end
end

Redmine::Plugin.register :meta_plugin do
    name 'Meta tags'
    author 'Andriy Lesyuk'
    author_url 'http://www.facebook.com/andriy.lesyuk'
    description 'Adds an ability to specify meta description and keywords.'
    version '0.0.1'
end
