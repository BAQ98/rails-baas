namespace :devise do
  desc "Send welcome reset password instructions to all users.
  This will lockout all users until they reset their password."
  task send_welcome_reset_password_instructions_to_all_auths: :environment do
    Auth.where.not(email: nil).in_batches(of: 10).each_record do |auth|
      # Send instructions so user can enter a new password:
      AuthMailer.welcome_reset_password_instructions(auth).deliver
      p auth.id
    end
  end
end