class Public::CustomersController < ApplicationController
   def show
    @customers = Customer.all
    @customer = Customer.find(current_customer.id)
   end

    def edit
      @customer = Customer.find(current_customer.id)
    end

    def update
      @customer = Customer.find(current_customer.id)
      @customer.update(customer_params)
      redirect_to public_customers_information_path
    end

    def withdraw
    end

    def withdraw_update
      @customer = current_customer
      @customer.update(is_deleted: true)
      reset_session
      redirect_to public_root_path
    end

    private
    def customer_params
      params.require(:customer).permit(:first_name, :last_name,:postal_code, :address, :telephone_number, :email)
    end

end

