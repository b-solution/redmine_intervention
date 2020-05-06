Redmine::Plugin.register :redmine_intervention do
  name 'Redmine Intervention plugin'
  author 'bilel kedidi'
  description 'This is a plugin for Redmine'
  version '0.0.1'

  project_module :intervention do
    permission :manage_intervention, :interventions => [:index, :edit, :update, :delete]
  end

end

  class RedmineInterventionHook < Redmine::Hook::ViewListener
    render_on :view_issues_show_details_bottom, :partial => "interventions/view_issues_show_details_bottom"
  end

require 'redmine_intervention/issue_patch'