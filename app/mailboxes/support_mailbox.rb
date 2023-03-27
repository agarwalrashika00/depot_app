class SupportMailbox < ApplicationMailbox
  def process
    recent_order = Order.where(email: mail.from[0]).order('created_at desc').first
    SupportRequest.create!(
      email: mail.from[0],
      subject: mail.subject,
      body: mail.body.to_s,
      order: recent_order
    )
  end
end