# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_lunchomizer_session',
  :secret      => '52ac6e2f4abcf1952e6cb20d4f447b967d9c9aecc09e7f678c30053717b9ca5c021d703b2d2457fe827b42577de87382739edef51b61c6785e6775e8ec68a7c0'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
