module ApplicationHelper
    def is_active?(link_path)
        current_page?(link_path) ? "active" : ""
    end

    def create_cart_and_assign_to_current_user
        if current_user != nil && current_user.cart == nil
            cart = Cart.create(user: current_user)
        end
    end
end
