# Instagram Clone

This application is an instagram clone which works like instgram. You can create post, story, like or comment. Also you can follow each other.

# Description
  - This application has a user login system. In which user can sign up by giving email, username and password.
  - The user can recover foget password by an email.
  - A user can have a name, bio, username, email, password. To edit this, the current password is required.
  - A user can create, edit and delete a post.
  - A post can be like or unlike by any user.
  - Any user can comment on any post.
  - A user can create a story, which will delete after 24 hours automatically, if user dont delete it.
  - A search bar is implemented, you can search for any user through this.

# Models
  - User
  - Post
  - Story
  - Comment
  - Like
  - Follow
  - Request

# Gems
  - active_storage_validations
  - bootstrap-sass
  - cloudinary
  - devise
  - faker
  - figaro
  - jquery-rails
  - kaminari
  - pg
  - pundit
  - ransack
  - sidekiq

# System dependencies
  - Rails 5.2.6
  - Ruby 2.7.0
  - psql (PostgreSQL) 14.0 (Ubuntu 14.0-1.pgdg20.04+1)
  - redis 5.0.7

# Setup Instructions
  - Clone the repository
  - check this link for cloning: git@github.com:akbar-hussain/instagram-clone.git
  - Install the dependencies by runing bundle install
  - Add your environment variables
    - GMAIL_USERNAME, GMAIL_PASSWORD
    - CLOUDINARY_CLOUD_NAME, CLOUDINARY_API_KEY, CLOUDINARY_API_SECRET
    - REDIS_URL
  - User rake db:setup to create database
  - Seed data in database
  - Start the rails server
  - go to http://localhost:3000/
