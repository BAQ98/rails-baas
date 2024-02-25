task send_welcome_reset_password_instructions_to_all_auths: :environment do
  Auth.take(100).in_batches(of: 10).each_record do |auth|
    # Send instructions so auth can enter a new password:
    AuthMailer.welcome_reset_password_instructions(auth).deliver
    p auth.id
  end
end