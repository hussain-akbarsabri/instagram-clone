# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(
  bio: 'Saya',
  username: 'saya.',
  name: 'hahah',
  email: 'aaa@aaa.com',
  password: 'foobar',
  password_confirmation: 'foobar'
)
user.image.attach('https://i.ytimg.com/vi/1Ne1hqOXKKI/maxresdefault.jpg')
