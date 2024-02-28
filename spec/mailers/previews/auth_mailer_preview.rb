# spec/mailers/previews/user_mailer_preview.rb
# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class AuthMailerPreview < ActionMailer::Preview
  def welcome_reset_password_instructions
    AuthMailer.reset_password_instructions(Auth.first)
  end
end