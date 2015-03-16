require 'redmine'
require 'redmine_fetch_email_feedback'

Rails.application.config.to_prepare do
  RedmineFetchEmailFeedback.apply_patch
end

Redmine::Plugin.register :redmine_fetch_email_feedback do
  name 'Redmine Fetch Email Feedback plugin'
  author 'James Lin <linjunhalida@gmail.com>'
  description 'Redmine plugin to send feedback when fetch email finished.'
  version '0.0.1'
  url 'https://github.com/halida/redmine_fetch_email_feedback'
  author_url 'http://blog.linjunhalida.com/'

  settings default: {
             enabled: false,
           }, partial: 'settings/redmine_fetch_email_feedback_settings'

end
