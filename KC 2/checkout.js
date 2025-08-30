// This is your test secret API key.
const stripe = Stripe("pk_test_51RarGdHK1JcHVlJVkZ2Yn7GkisB3dscyQRNu5JjHYmyb0q6aL33aUXZFJlq8anYP4AWk4c6GFfX8iAWcmkYf1SLE00ExCLtImn");

initialize();

// Create a Checkout Session
async function initialize() {
  const fetchClientSecret = async () => {
    const response = await fetch("/create-checkout-session", {
      method: "POST",
    });
    const { clientSecret } = await response.json();
    return clientSecret;
  };

  const checkout = await stripe.initEmbeddedCheckout({
    fetchClientSecret,
  });

  // Mount Checkout
  checkout.mount('#checkout');
}