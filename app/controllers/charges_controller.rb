class ChargesController < ApplicationController
  
  after_action :change_role, only: [:create]
  
  class Amount
    def self.default
      @amount = 15_00
    end
    
    def self.refund
      @amount = 12_00
    end  
  end
  
  def new
     @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     description: "BigMoney Membership - #{current_user.email}",
     amount: Amount.default
   }
  end

  def create
     customer = Stripe::Customer.create(
     email: current_user.email,
     card: params[:stripeToken]
   )
 
   charge = Stripe::Charge.create(
     customer: customer.id, # Note -- this is NOT the user_id in your app
     amount: Amount.default,
     description: "BigMoney Membership - #{current_user.username}",
     currency: 'usd'
   )
   
   current_user.charge_id = charge.id
   current_user.save!
 
   flash[:notice] = "Thanks for all the money, #{current_user.username}! Feel free to pay me again."
   redirect_to wikis_path 
   
   rescue Stripe::CardError => e
     flash[:alert] = e.message
     redirect_to new_charge_path
  end

  def destroy
    #stripe stuff to refund $12
   
     Stripe::Refund.create(
     charge: current_user.charge_id,
     amount: Amount.refund
   )
 
   flash[:notice] = "Your membership charge has been refunded (minus admin costs of $3.00), #{current_user.username}! Feel free to upgrade your membership again in the future."
   redirect_to wikis_path 
   
   #publicise all the private wikis
   Wiki.all.each do |w|
     if w.user_id == current_user.id && w.private
       w.private = false
       w.save!
     end
   end    
          
   current_user.role = 'standard'
   current_user.save!
   
   rescue Stripe::CardError => e
     flash[:alert] = e.message
     redirect_to new_charge_path
     
    
  end
  
  private
  
  def change_role
    current_user.role = :premium
    current_user.save
  end  
    
    
end
