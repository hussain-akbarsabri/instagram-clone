# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(
  email: 'taha@gmail.com',
  password: '123123',
  password_confirmation: '123123',
  username: 'taha_',
  name: 'taha',
  bio: 'i am here'
)

User.create(
  email: 'ali@gmail.com',
  password: '123123',
  password_confirmation: '123123',
  username: 'ali_',
  name: 'ali',
  bio: 'i am here'
)

User.create(
  email: 'ahmad@gmail.com',
  password: '123123',
  password_confirmation: '123123',
  username: 'ahmad_',
  name: 'ahmad',
  bio: 'i am here'
)
# save image