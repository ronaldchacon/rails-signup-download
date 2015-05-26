class MailingListSignupJob < ActiveJob::Base
  def perform(user)
    logger.info "Signing up #{user.email}"
    user.subscribe
  end
end