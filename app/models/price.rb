class Price < ApplicationRecord
  validates :name, presence: true
  validates :value, presence: true
  
  def self.ransackable_attributes(auth_object = nil)
    %w[created_at id name updated_at value]
  end
end
