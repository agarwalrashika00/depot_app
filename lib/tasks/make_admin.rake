task :make_admin, [:email] => :environment do |t, args|
  User.where(email: args[:email]).each do |admin|
    admin.update_columns(role: 'admin')
  end
end