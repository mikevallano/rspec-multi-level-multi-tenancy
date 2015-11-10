def switch_to_subdomain(subdomain)
  # lvh.me always resolves to 127.0.0.1
  # hostname = subdomain ? "#{subdomain}.lvh.me" : "lvh.me"
  hostname = subdomain ? "#{subdomain}.lvh.me:3000" : "lvh.me:3000"
  Capybara.app_host = "http://#{hostname}"
end

def switch_to_no_subdomain
  switch_to_subdomain nil
end

# RSpec.configure do |config|
#   switch_to_main_domain
# end

# Capybara.configure do |config|
#   config.always_include_port = true
# end