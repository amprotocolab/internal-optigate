module API
  module V1
    class PaymentsController < APIController
      def create_payment_intent
        amount = params[:amount] 

        payment_intent = Stripe::PaymentIntent.create(
          amount: amount,
          currency: 'usd',
          description: 'Payment for your service',
          payment_method: params[:payment_method],
          confirmation_method: 'manual',
          confirm: true
        )

        render json: { client_secret: payment_intent.client_secret }
      end
    end
  end
end
