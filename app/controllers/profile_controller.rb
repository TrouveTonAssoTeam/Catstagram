class ProfileController < ApplicationController
    before_action :authenticate_user!

    def show
        @user = current_user

        # @orders = @user.orders
        @orders = []
    end

    def edit
        @user = current_user
    end

    def update
        @user = current_user

        @user.first_name = params[:user][:first_name]
        @user.last_name = params[:user][:last_name]
        @user.address = params[:user][:address]
        @user.city = params[:user][:city]
        @user.postal_code = params[:user][:postal_code]
        @user.country = params[:user][:country]
        @user.phone = params[:user][:phone]

        puts "#" * 50
        puts params[:user][:first_name]
        puts "#" * 50

        if @user.save
            redirect_to profile_path
            notice = "Your profile has been updated"
        else 
            render :edit
        end
    end
end
