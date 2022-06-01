Hashid::Rails.configure do |config|
  # The salt to use for generating hashid. Prepended with table name.
  config.salt = "We can change this later"

  # The minimum length of generated hashids
  config.min_hash_length = 6

  # The alphabet to use for generating hashids
  config.alphabet = "abcdefghijklmnopqrstuvwxyz" \
                    "ABCDEFGHIJKLMNOPQRSTUVWXYZ" \
                    "1234567890"

  # Whether to override the `find` method
  config.override_find = false

  # Whether to sign hashids to prevent conflicts with regular IDs (see https://github.com/jcypret/hashid-rails/issues/30)
  config.sign_hashids = true
end

# We could add this in the Scans controller if needed:
# And inside your controller, use find_by_hashid instead of find:
# users_controller.rb
# ...
  # def set_user
  #   @user = User.find_by_hashid(params[:id])
  # end
