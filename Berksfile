source 'https://supermarket.getchef.com'

metadata

cookbook 'apt'
cookbook 'nginx'

group :testing do
  cookbook 'supervisor'
  cookbook 'supervisor-daemon', path: 'test/cookbooks/supervisor-daemon'
end
