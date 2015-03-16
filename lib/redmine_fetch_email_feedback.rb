module RedmineFetchEmailFeedback
  def self.apply_patch
    require 'redmine_fetch_email_feedback/mail_handler_patch'
    require 'redmine_fetch_email_feedback/mailer_patch'
  end  
end
