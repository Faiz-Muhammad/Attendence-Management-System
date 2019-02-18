ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address                => 'smtp.sendgrid.net',
  :port                   => '587',
  :authentication         => :plain,
  :user_name              => 'app125240587@heroku.com',
  :password               => 'dr1a1ezv5397',
  :domain                 => 'heroku.com',
  :enable_starttls_auto   => true
}
