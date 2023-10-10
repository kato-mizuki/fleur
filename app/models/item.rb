class Item < ApplicationRecord

 def with_tax_price
    (price * 1.10).floor
 end
 has_one_attached :image
 has_many :cart_items, dependent: :destroy
 has_many :order_detail
end
