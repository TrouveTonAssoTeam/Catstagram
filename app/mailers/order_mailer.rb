class OrderMailer < ApplicationMailer
    default from: ENV["MAILJET_ACCOUNT"]

    def confirm_order(user, order)
        @user = user
        @order = order

        mail(to: @user.email, subject: "Commande confirmée !")
    end

    def new_order_admin(order)

    end
end
