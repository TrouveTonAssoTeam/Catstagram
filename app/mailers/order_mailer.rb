class OrderMailer < ApplicationMailer
    default from: ENV["MAILJET_ACCOUNT"]

    def confirm_order(user, order)
        @user = user
        @order = order

        mail(to: @user.email, subject: "Commande confirmée !")
    end

    def new_order_admin(order)
        @order = order
        
        User.where(role: "admin").each do |user|
            mail(to: user.email, subject: "Nouvelle commande !")
        end
    end
end
