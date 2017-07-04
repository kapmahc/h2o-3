CarrierWave.configure do |config|
  config.fog_provider = 'fog/local'
  config.fog_credentials = {
      provider: 'Local',
      local_root: Rails.root.join('public'),
      endpoint: '/tmp',
  }
  config.fog_directory  = 'tmp'

end