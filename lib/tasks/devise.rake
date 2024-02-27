namespace :devise do
  desc "Send welcome reset password instructions to all auths.
  This will lockout all auths until they reset their password."
  task send_reset_password_instructions_to_auth: :environment do
    # Send instructions so auth can enter a new password:
    AuthMailer.send_reset_password_instructions(Auth.first).deliver
  end
end