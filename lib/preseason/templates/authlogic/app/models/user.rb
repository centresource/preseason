
  acts_as_authentic do |c|
    # because RSpec has problems with Authlogic's session maintenance
    # see https://github.com/binarylogic/authlogic/issues/262#issuecomment-1804988
    c.maintain_sessions = false
  end

  def send_password_reset_instructions!
    reset_perishable_token!
    SiteMailer.password_reset_instructions(self).deliver
  end
