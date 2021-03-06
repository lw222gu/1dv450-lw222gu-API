# This file should contain all the record creation needed to seed the
# database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the
# db with db:setup).

developer_role = Role.create
developer_role.role = 'developer'

admin_role = Role.create
admin_role.role = 'admin'

admin = User.create
admin.username = 'admin'
admin.password = 'pass123'
admin.password_confirmation = 'pass123'
admin.role_id = 2
admin.save

developer = User.create
developer.username = 'developer'
developer.password = '123456'
developer.password_confirmation = '123456'
developer.role_id = 1
developer.save

c = Client.create
c.name = 'En applikation'
c.description = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit,
  sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
c.url = 'www.test.se'
c.user_id = 2
c.save
c.key = 1234567890 # added this only to get postman file to work easily.
c.save

c2 = Client.create
c2.name = 'En annan applikation'
c2.description = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit,
  sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
c2.url = 'www.test.se'
c2.user_id = 2
c2.active = false
c2.save

r = ResourceOwner.create
r.username = 'resourceowner'
r.password = '123456'
r.password_confirmation = '123456'
r.save

r2 = ResourceOwner.create
r2.username = 'resourceowner2'
r2.password = '123456'
r2.password_confirmation = '123456'
r2.save

location = Location.create
location.address = 'Falun'
location.save

location2 = Location.create
location2.latitude = 60.6341456
location2.longitude = 15.8613386
location2.save

location3 = Location.create
location3.address = 'Borlänge'
location3.save

tag = Tag.create
tag.tag = 'JavaScript'
tag.save

tag2 = Tag.create
tag2.tag = 'HTML'
tag2.save

salary = Salary.create
salary.wage = 28_000
salary.title = 'Web developer'
salary.location_id = 1
salary.resource_owner_id = 1
salary.save

salary2 = Salary.create
salary2.wage = 29_500
salary2.title = 'Webbutvecklare'
salary2.location_id = 2
salary2.resource_owner_id = 2
salary2.save

salary.tags << tag
salary.tags << tag2
salary2.tags << tag
