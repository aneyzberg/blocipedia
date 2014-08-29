class ChargesController < ApplicationController
  def create

    @amount = params[:amount]

    # Creates a Stripe Customer object, for associating
     # with the charge

    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
      )

    # Where the real magic happens

    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: @amount,
      description: "Premium Membership - #{current_user.email}",
      currency: 'usd'
      )

    current_user.update_attribute(:premium, true)

      flash[:success] = "Thanks you #{current_user.email} for signing up for premium!."
      redirect_to wikis_path # or wherever

       # Stripe will send back CardErrors, with friendly messages
      # when something goes wrong.
      # This `rescue block` catches and displays those errors.

  rescue Stripe::CardError => e
      flash[:error] = e.messages
      redirect_to new_charge_path
      
  end

  def new 
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Premium membership = #{current_user.name}",
      amount: 2000
    }
  end

end