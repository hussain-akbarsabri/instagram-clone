# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@instagram.com'
  layout 'mailer'
end
