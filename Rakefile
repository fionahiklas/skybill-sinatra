require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  ENV['RACK_ENV'] = 'test'
  t.libs << "test"
  t.libs << "lib"
  t.pattern = 'test/**/test_*.rb'
  t.warning = true
end

Rake::TestTask.new(:test_client) do |t|
  ENV['RACK_ENV'] = 'test'
  t.libs << "test"
  t.libs << "lib"
  t.pattern = 'test/test_client.rb'
  t.warning = true
end

Rake::TestTask.new(:test_server) do |t|
  ENV['RACK_ENV'] = 'test'
  t.libs << "test"
  t.libs << "lib"
  t.pattern = 'test/test_server.rb'
  t.warning = true
end

