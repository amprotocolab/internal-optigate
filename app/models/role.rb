class Role < ApplicationRecord
  PERMITTED = {
    super_admin: 'SUPER_ADMIN',
    app_user:    'APP_USER'
  }.freeze

  validates :name, inclusion: { in: PERMITTED.values.map(&:to_s) }, uniqueness: true

  scope :super_admin, -> { where(name: PERMITTED.fetch(:super_admin)).first }
  scope :app_user,    -> { where(name: PERMITTED.fetch(:app_user)).first }

  has_and_belongs_to_many :users

  def super_admin?
    name == PERMITTED.fetch(:super_admin)
  end

  def app_user?
    name == PERMITTED.fetch(:app_user)
  end
end
