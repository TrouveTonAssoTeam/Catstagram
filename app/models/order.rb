class Order < ApplicationRecord
    after_create :send_confirmation_email

    belongs_to :user 
    has_many :items

    def send_confirmation_email
        OrderMailer.confirm_order(current_user, self).deliver_now
        OrderMailer.new_order_admin(self).deliver_now
    end
end
