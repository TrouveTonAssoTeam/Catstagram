class PaymentController < ApplicationController
    before_action :authenticate_user!

    def create
        # Recall the user and check if he have a Stripe Id
        @user = current_user
        if @user.Stripe_id
          @customer = Stripe::Customer.retrieve(@user.Stripe_id)
        else
          @customer = Stripe::Customer.create(
            email: @user.email
          )
          @user.update(Stripe_id: @customer.id)
        end

        @total = params[:total].to_d

        @line_items = current_user.cart.join_table_items_carts.map do |item|
          {
            price: Item.find(item.item_id).stripe_price,
            quantity: item.quantity
          }
        end

        @session = Stripe::Checkout::Session.create(
          payment_method_types: ['card'],

        #   Pass the customer ID to the Checkout Session
          customer: @customer.id,

        #   Require the customer to add an address for shipping and billing
          billing_address_collection: 'required',
          shipping_address_collection: {
            allowed_countries: ['FR', 'BE', 'CH'],
          },

        #   Retrieve items id from the cart
          line_items: @line_items,
          mode: 'payment',
          success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
          cancel_url: checkout_cancel_url
        )
        redirect_to @session.url, allow_other_host: true
      end
    
    def success
        @session = Stripe::Checkout::Session.retrieve(params[:session_id])
        @customer = Stripe::Customer.retrieve(@session.customer)
        
        # Update the stripe customer information with the current session if not defined
        if @customer.name == nil
          @customer.name = @session.customer_details.name
          @customer.save
        end
        if @customer.address == nil
          @customer.address = @session.customer_details.address
          @customer.save
        end

        # Create an order after successful payment only if not already created
        if Order.where(stripe_id: @session.id).count == 0
          @order = Order.new(
              user_id: current_user.id,
              stripe_id: @session.id,
          )

          current_user.cart.join_table_items_carts.each do |item|
            if item.quantity == 1
              @order.items << Item.find(item.item_id)
            else
              @order.orderitems << Orderitem.new(
                item_id: item.item_id,
                order_id: @order.id,
                quantity: item.quantity
              )
            end
          end

          if @order.save
            current_user.cart.join_table_items_carts.destroy_all
          end
        end
    end
    
    def cancel
    end
end
