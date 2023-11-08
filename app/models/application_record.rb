class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  after_initialize :ensure_uuid

  def dup
    copy = super
    copy.uuid = SecureRandom.uuid if respond_to?(:uuid=)

    copy
  end

  private

  def ensure_uuid
    self.uuid = SecureRandom.uuid if respond_to?(:uuid=) && uuid.blank?
  end
end
