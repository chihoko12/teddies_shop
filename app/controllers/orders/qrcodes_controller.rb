class Orders::QrcodesController < ApplicationController

  def show
    @order = Order.find(params[:order_id])

    options = {
        offset: 0,
        color: '000',
        shape_rendering: 'crispEdges',
        module_size: 6
      }

    @text = order_path(@order)
    @qrcode = RQRCode::QRCode.new(@text)
    @svg = @qrcode.as_svg(options)
  end

end
