namespace :devise do
  desc "Send welcome reset password instructions to all auths.
  This will lockout all auths until they reset their password."
  task send_welcome_reset_password_instructions_to_all_auths: :environment do
    Auth.limit(1).each do |auth|
      # Send instructions so auth can enter a new password:
      AuthMailer.welcome_reset_password_instructions(auth).deliver
      p auth.id
    end
  end
end