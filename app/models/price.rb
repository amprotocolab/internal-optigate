class Price < ApplicationRecord
  has_many :price_pointers, dependent: :destroy
  accepts_nested_attributes_for :price_pointers, allow_destroy: true
  validates :name, presence: true
  validates :value, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[created_at id name updated_at value]
  end

  def self.ransackable_associations(auth_object = nil)
    ["price_pointers"]
  end
end
