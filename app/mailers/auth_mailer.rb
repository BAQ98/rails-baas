class AuthMailer < Devise::Mailer
  include Devise::Controllers::UrlHelpers
  default template_path: 'auths/mailer'

  def welcome_reset_password_instructions(auth)
    create_reset_password_token(auth)
    mail(to: auth.email, subject: 'Welcome to the New Site')
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