class MetaHook  < Redmine::Hook::ViewListener

    render_on :view_issues_show_description_bottom, :partial => 'meta/issues'
    render_on :view_projects_show_sidebar_bottom,   :partial => 'meta/projects'
    render_on :view_welcome_index_left,             :partial => 'meta/welcome'

    render_on :view_news_show_left,                 :partial => 'meta/news'
    render_on :view_wiki_show_left,                 :partial => 'meta/wiki'

    render_on :view_versions_show_bottom,           :partial => 'meta/versions'
    render_on :view_account_left_bottom,            :partial => 'meta/users'

end
