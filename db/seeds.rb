# frozen_string_literal: true

require 'open-uri'
require 'faker'

def image_fetcher
  URI.parse(Faker::Avatar.image).open
end

20.times do |n|
  user = User.new(
    email: Faker::Internet.unique.email,
    password: '123123',
    password_confirmation: '123123',
    name: Faker::Name.name,
    username: Faker::Name.unique.name[2..15],
    bio: Faker::Name.name
  )
  user.image.attach({
                      io: image_fetcher,
                      filename: "#{n}_faker_image.jpg"
                    })
  user.save!
end

20.times do |n|
  user = User.first
  post = user.posts.new(
    caption: Faker::Lorem.paragraph
  )
  post.images.attach({
                       io: image_fetcher,
                       filename: "#{n}_faker_image.jpg"
                     })
  post.save!
end

20.times do |n|
  user = User.first
  story = user.stories.new
  story.image.attach({
                       io: image_fetcher,
                       filename: "#{n}_faker_image.jpg"
                     })
  story.save!
end
