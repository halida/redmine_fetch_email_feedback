require_dependency 'mail_handler'

module RedmineFetchEmailFeedback
  module MailHandlerPatch
    extend ActiveSupport::Concern
    
    included do
      unloadable
      alias_method_chain :receive, :send_feedback
      alias_method_chain :logger, :redirect_to_string
    end

    def logger_with_redirect_to_string
      if @log_redirect_to_string
        @string_io ||= StringIO.new
        @string_logger ||= Logger.new(@string_io)
      else
        Rails.logger
      end
    end

    def wrap_logger_with_string
      @log_redirect_to_string = true
      begin
        yield
      ensure
        @log_redirect_to_string = false
      end
      
      if @string_io.blank?
        ""
      else
        @string_io.string.force_encoding('ASCII-8BIT')
      end
    end

    def receive_with_send_feedback(email)
      result = nil
      log = wrap_logger_with_string do
        result = receive_without_send_feedback(email)
      end
      
      sender = email.from.to_a.first.to_s.strip
      subject = email.subject.to_s
      
      if Setting.plugin_redmine_fetch_email_feedback[:enabled] and # enabled
        sender != Setting.mail_from.try(:strip) # feedback should not send to self
        Mailer.receive_mail_feedback(email: sender, subject: subject, result: result, log: log).deliver
      end
      result
    end

    MailHandler.send(:include, MailHandlerPatch)
  end
end
