# This file should contain all the record creation needed to seed the
# database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the
# db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

creator_role = Role.create
creator_role.role = 'creator'

developer_role = Role.create
developer_role.role = 'developer'

admin_role = Role.create
admin_role.role = 'admin'

admin = User.create
admin.username = 'admin'
admin.password = 'pass123'
admin.password_confirmation = 'pass123'
admin.role_id = 3
admin.save

developer = User.create
developer.username = 'developer'
developer.password = '123456'
developer.password_confirmation = '123456'
developer.role_id = 2
developer.save

creator = User.create
creator.username = 'creator'
creator.password = '123456'
creator.password_confirmation = '123456'
creator.role_id = 1
creator.save

c = Client.create
c.name = 'En applikation'
c.description = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit,
  sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
c.url = 'www.test.se'
c.key = DateTime.now.strftime('%s') + SecureRandom.hex(20)
c.user_id = 2
c.save

salary = Salary.create
salary.salary = 28_000
salary.title = 'Web developer'
salary.save

salary2 = Salary.create
salary2.salary = 29_500
salary2.title = 'Web developer'
salary2.save
