class ApplicationMailer < ActionMailer::Base
  default from: "\"All That's Local\" <no-reply@example.com>"
  layout 'mailer'
  binding.pry
end
