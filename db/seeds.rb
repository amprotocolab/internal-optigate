ApplicationRecord.transaction do
  # Roles
  super_admin  = Role.find_or_create_by!(name: Role::PERMITTED.fetch(:super_admin))
  app_user = Role.find_or_create_by!(name: Role::PERMITTED.fetch(:app_user))

  unless Rails.env.production?
    # Super Admin
    User.find_or_initialize_by(email: 'tash@advertising.com').tap do |user|
      user.uid                   = 'tash@advertising.com'
      user.first_name            = 'Tash'
      user.last_name             = 'Advertising'
      user.phone_number          = '+5551234567'
      user.password              = '1234567890'
      user.password_confirmation = '1234567890'
      user.roles                 = [super_admin]
      user.save
    end

    # App User
    User.find_or_initialize_by(email: 'anab@agencywatcher.com').tap do |user|
      user.uid                   = 'anab@agencywatcher.com'
      user.first_name            = 'Anab'
      user.last_name             = 'Imam'
      user.phone_number          = '+5551234567'
      user.password              = '1234567890'
      user.password_confirmation = '1234567890'
      user.roles                 = [app_user]
      user.save
    end
  end
end
