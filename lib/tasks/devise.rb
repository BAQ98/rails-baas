task send_reset_password_instructions_to_auth: :environment do
  # Send instructions so auth can enter a new password:
  AuthMailer.send_reset_password_instructions(Auth.first).deliver
end