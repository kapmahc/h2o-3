CarrierWave.configure do |config|
  # config.fog_provider = 'fog/aws'
  # config.fog_credentials = {
  #     provider: 'AWS',
  #     aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
  #     aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
  #     endpoint: ENV['AWS_ENDPOINT'],
  # }
  # config.fog_directory  = ENV['HOST']



  config.fog_provider = 'fog/local'
  config.fog_credentials = {
      provider: 'Local',
      local_root: Rails.root.join('public'),
      endpoint: '/',
  }
  config.fog_directory = 'tmp'

end