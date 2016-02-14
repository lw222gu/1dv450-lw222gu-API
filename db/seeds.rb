# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.create
admin.username = 'admin'
admin.password = 'pass123'
admin.password_confirmation = 'pass123'
admin.admin = true
admin.save

u = User.create
u.username = 'user'
u.password = '123456'
u.password_confirmation = '123456'
u.save

c = Client.create
c.name = 'En applikation'
c.description = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
c.url = 'www.test.se'
c.key = DateTime.now.strftime('%s') + SecureRandom.hex(20)
c.user_id = 2
c.save
