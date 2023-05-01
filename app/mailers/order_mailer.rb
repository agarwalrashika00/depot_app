class OrderMailer < ApplicationMailer
  default from: 'Sam Ruby <depot@example.com>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.received.subject
  #
  def received(order)
    @order = order
    line_items = @order.line_items

    line_items.each do |line_item|
      images = line_item.product.images.to_a
      attachments.inline["#{line_item.id}_first.jpg"] = Rails.root.join('app', 'assets', 'images', "#{images.shift.url}").binread
      images.each do |image|
        attachments["#{line_item.id}_#{image.id}.jpg"] = Rails.root.join('app', 'assets', 'images', "#{image.url}").binread
      end
    end

    mail to: order.email, subject: 'Pragmatic Store Order Confirmation'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.shipped.subject
  #
  def shipped(order)
    @order = order

    mail to: order.email, subject: 'Pragmatic Store Order Shipped'
  end
end
