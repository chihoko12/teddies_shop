class OrdersController < ApplicationController
  def create
    teddy = Teddy.find(params[:teddy_id])
    order = Order.create!(teddy: teddy, teddy_sku: teddy.sku, amount: teddy.price, state: 'pending', user: current_user)

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: teddy.sku,
        images: [teddy.photo_url],
        amount: teddy.price_cents,
        currency: 'eur',
        quantity: 1
      }],
      success_url: order_url(order),
      cancel_url: order_url(order)
      )
    order.update(checkout_session_id: session.id)
    redirect_to order_qrcode_path(order)
  end

  def show
    @order = current_user.orders.find(params[:id])
  end
end
