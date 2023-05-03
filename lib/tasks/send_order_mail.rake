task :send_order_mail => :environment do
  User.all.each do |user|
    OrderMailer.with(user: user).send_orders_summary.deliver_now
  end
end