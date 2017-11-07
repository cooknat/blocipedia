 # Store the environment variables on the Rails.configuration object
 Rails.configuration.stripe = {
   publishable_key: 'pk_test_M7IUHignIWfu6pyTAxNeGJvA',
   secret_key: ENV['STRIPE_SECRET_KEY']
 }
 
 # Set our app-stored secret key with Stripe
 Stripe.api_key = Rails.configuration.stripe[:secret_key]