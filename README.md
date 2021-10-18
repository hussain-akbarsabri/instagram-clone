# README

Instagram Clone

This application is built using ruby 2.7 and rails 5.2
The database used is postgres

Description
  This application has a user login system. In which user can sign up by giving email, username and password.
  The user can recover foget password by an email.
  A user can have a name, bio, username, email, password. To edit this, the current password is required.
  A user can create, edit and delete a post.
  A post can be like or unlike by any user.
  Any user can comment on any post.
  A user can create a story, which will delete after 24 hours automatically, if user dont delete it.
  A search bar is implemented, you can search for any user through this.

Gems
  active_storage_validations
  bootstrap-sass
  devise
  jquery-rails
  pg
  pundit
  ransack
  sidekiq

Run the application
  Start the rails server (rails s)
  Start the sidekiq (sidekiq)

System dependencies
  Rails 5.2
  Ruby 2.7
  Redis
  Sidekiq
  Jquery
