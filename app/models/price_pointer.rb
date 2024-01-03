class PricePointer < ApplicationRecord
  belongs_to :price

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "price_id", "subtitle", "updated_at"]
  end
  
end
