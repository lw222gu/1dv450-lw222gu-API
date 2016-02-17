bundle install
rake db:schema:load
rake db:seed
rails s -b 0.0.0.0
exit
