# frozen_string_literal: true
class User < ApplicationRecord
  extend Devise::Models
  include PgSearch::Model
  include ImageUploader::Attachment(:image)

  PASSWORD_PARAMS = [
    :password, :password_confirmation, :current_password
  ].freeze

  ATTRIBUTE_WHITELIST = [
    :email,
    :first_name,
    :last_name,
    :phone_number,
    :password,
    :password_confirmation,
    :current_password,
    :image,
    :remove_image
  ].concat(PASSWORD_PARAMS).freeze

  before_validation :assign_default_role!, on: :create

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  scope :by_full_name, lambda { |name|
    matched_ids = search_by_full_name(name).pluck(:id)
    where(id: matched_ids)
  }

  scope :admins,   -> { joins(:roles).where(roles: { name: Role::PERMITTED.fetch(:super_admin) }) }
  scope :app_user, -> { joins(:roles).where(roles: { name: Role::PERMITTED.fetch(:app_user) }) }

  pg_search_scope :search_by_full_name,
  against: [:first_name, :last_name],
  using: {
    tsearch: {
      prefix: true,
      any_word: true
    }
  }

  has_and_belongs_to_many :roles

  def full_name
    "#{first_name} #{last_name}"
  end

  def administrator?
    roles.any?(&:super_admin?)
  end

  def app_user?
    roles.any?(&:app_user?)
  end

  def self.signin_or_create_from_provider(provider_data)
    where(provider: provider_data[:provider], uid: provider_data[:uid]).first_or_create do |user|
      user.email = provider_data[:info][:email]
      user.password = Devise.friendly_token[0, 20]
      # user.skip_confirmation! # when you signup a new user, you can decide to skip confirmation
    end
  end

  private

  def assign_default_role!
    return if roles.exists?(name: Role::PERMITTED.fetch(:app_user))

    self.roles = [Role.app_user]
  end
end

