# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create(name: 'Programming', slug: 'programming')
Category.create(name: 'Web Design', slug: 'web-design')
Category.create(name: 'Marketing', slug: 'marketing')
Category.create(name: 'Accounting', slug: 'accounting')

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
