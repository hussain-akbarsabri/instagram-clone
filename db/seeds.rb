# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'faker'

def image_fetcher
  URI.parse(Faker::Avatar.image).open
end

20.times do |n|
  user = User.create(
    email: Faker::Internet.email,
    password: '123123',
    password_confirmation: '123123',
    name: Faker::Name.name,
    username: Faker::Name.name,
    bio: Faker::Name.name
  )
  user.image.attach({
                      io: image_fetcher,
                      filename: "#{n}_faker_image.jpg"
                    })
end
