class RentalsController < ApplicationController

    def new 
        @rental = Rental.new
        redirect_to rentals_path
    end 


    def create_rental
        
        @new_rental = Rental.create(rental_params)
        @new_rental.user = current_user
        if @new_rental.save
            flash[:notice] = "You have successfully rented #{@new_rental.instrument.name}"
            redirect_to user_path(current_user)
        end
    end


    def destroy 
        session[:rental] = current_rental.id
        current_rental.destroy
        redirect_to user_path(current_user)
    end 


    def current_rental
        @rental = Rental.find(params[:id])
    end


    private

    def rental_params
        params.require(:rental).permit(:user_id, :instrument_id)
    end
end
