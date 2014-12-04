source 'https://supermarket.getchef.com'

metadata

cookbook 'apt'
cookbook 'nginx'
cookbook 'runit'
cookbook 'supervisor'

group :testing do
  cookbook 'supervisor-daemon', path: 'test/cookbooks/supervisor-daemon'
end
