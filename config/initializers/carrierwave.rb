# frozen_string_literal: true

# Default CarrierWave setup.
#
# CarrierWave.configure do |config|
#   config.permissions = 0o666
#   config.directory_permissions = 0o777
#   config.storage = :file
#   config.enable_processing = !Rails.env.test?
# end

# Setup CarrierWave to use Amazon S3. Add `gem "fog-aws" to your Gemfile.
#
CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_provider = 'fog/aws'                                           # required
  config.fog_credentials = {
    endpoint: 'deseo-compartir-6tr89wxujweezzxryncah68ada6ghsae1a-s3alias'
    provider:              'AWS',                                           # required
    aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],     # required
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'], # required
    region:                'sa-east-1',                                # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'deseocompartir'                                  # required
  config.fog_attributes = {
    'Cache-Control' => "max-age=#{365.day.to_i}",
    'X-Content-Type-Options' => "nosniff"
  }
end
