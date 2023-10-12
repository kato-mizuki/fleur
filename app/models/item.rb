class Item < ApplicationRecord

 def with_tax_price
    (price * 1.10).floor
 end
 has_one_attached :image
 has_many :cart_items, dependent: :destroy
 has_many :order_detail
 has_many :favorites, dependent: :destroy
  
 def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
 end
end
