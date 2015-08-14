require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require_relative '../lib/bond'
require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'
require 'byebug'

VCR.configure do |c|
  c.cassette_library_dir = 'test/fixtures'
  c.hook_into :webmock
  c.ignore_hosts 'codeclimate.com'
end

Bond.api_key = 'UXpj28zjyvQ20exTENfVqm1Ydcy7TjM2'