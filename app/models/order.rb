class Order < ApplicationRecord
    after_create :send_confirmation_email

    belongs_to :user 
    has_many :orderitems
    has_many :items, through: :orderitems

    def send_confirmation_email
        OrderMailer.confirm_order(self.user, self).deliver_now
        OrderMailer.new_order_admin(self).deliver_now
    end
end
