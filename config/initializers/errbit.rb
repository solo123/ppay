Airbrake.configure do |config|
  config.host = 'http://error.pooul.cn'
  config.project_id = true
  config.project_key = '70d5d8ef8247496e64757041b2333e84'
end if Rails.env.production?
