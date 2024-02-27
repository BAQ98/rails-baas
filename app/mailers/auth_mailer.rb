class AuthMailer < Devise::Mailer
  include Devise::Controllers::UrlHelpers
  default template_path: 'devise/mailer'

  def send_reset_password_instructions(auth)
    create_reset_password_token(auth)
    mail(to: auth.email, subject: 'Reset your password')
  end

  private

  def create_reset_password_token(auth)
    raw, hashed = Devise.token_generator.generate(Auth, :reset_password_token)
    @token = raw
    auth.reset_password_token = hashed
    auth.reset_password_sent_at = Time.now.utc
    auth.save
  end

end