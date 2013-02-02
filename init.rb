require 'redmine'

require_dependency 'meta_hook'

Rails.logger.info 'Starting Meta Tags Plugin for Redmine'

Rails.configuration.to_prepare do
    unless String.method_defined?(:html_safe)
        String.send(:include, MetaStringHTMLSafePatch)
    end
    unless ActionView::Base.included_modules.include?(MetaHelper)
        ActionView::Base.send(:include, MetaHelper)
    end
end

# TODO: Open Graph "profile" for users

Redmine::Plugin.register :meta do
    name 'Meta tags'
    author 'Andriy Lesyuk'
    author_url 'http://www.andriylesyuk.com'
    description 'Adds an ability to specify meta description and keywords.'
    url 'http://projects.andriylesyuk.com/projects/redmine-meta'
    version '0.2.0'

    settings :default => {
        :facebook_admins              => nil,
        :facebook_app                 => nil,
        :open_graph                   => true,
        :open_graph_site              => nil,
        :twitter_cards                => true,
        :twitter_site                 => nil,
        :twitter_user_custom_field    => nil,
        :twitter_project_custom_field => nil,
    }, :partial => 'settings/meta'
end
