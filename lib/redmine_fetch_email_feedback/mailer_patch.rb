require_dependency 'mailer'

module FetchEmailFeedback
  module MailerPatch
    
    def receive_mail_feedback(data)
      @data = data
      mail to: data[:email], subject: data[:subject]
    end

    Mailer.send(:include, MailerPatch)
  end
end
