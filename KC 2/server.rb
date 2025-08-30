require 'stripe'
require 'sinatra'

# This is your test secret API key.
Stripe.api_key = 'sk_test_51RarGdHK1JcHVlJVVckvgawd5ymvrEKxjlSfcwmZrNocMoUhelMa6BO9FD9SMDSPs4t1er3AmrYlZWBMXiAwmR9m008Ubh5hCB'

set :static, true
set :port, 4242

YOUR_DOMAIN = 'http://localhost:4242'

post '/create-checkout-session' do
  content_type 'application/json'

  session = Stripe::Checkout::Session.create({
    ui_mode: 'embedded',
    submit_type: 'Subscribe',
    billing_address_collection: 'required',
    line_items: [{
      # Provide the exact Price ID (e.g. price_1234) of the product you want to sell
      price: 'price_1Rb62lHK1JcHVlJV7rjsRLpc',
      quantity: 1,
    }],
    mode: 'subsrciption',
    return_url: YOUR_DOMAIN + '/return.html?session_id={CHECKOUT_SESSION_ID}',
    automatic_tax: {enabled: true},
  })

  {clientSecret: session.client_secret}.to_json
end

get '/session-status' do
  session = Stripe::Checkout::Session.retrieve(params[:session_id])

  {status: session.status, customer_email:  session.customer_details.email}.to_json
end