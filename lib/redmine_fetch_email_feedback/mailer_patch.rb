require_dependency 'mailer'

module FetchEmailFeedback
  module MailerPatch
    
    def receive_mail_feedback(email, subject, result, log)
      @result = result
      @log = log
      mail to: email, subject: subject
    end

    Mailer.send(:include, MailerPatch)
  end
end
