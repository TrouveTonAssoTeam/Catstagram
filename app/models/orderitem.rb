class Orderitem < ApplicationRecord
    belongs_to :item
    belongs_to :order
    after_initialize :init

    def init
      self.quantity ||= 1           #will set the default value only if it's nil
      self.price = self.item.price  #set the price to the price of the item in case of modification of the item
    end
end
