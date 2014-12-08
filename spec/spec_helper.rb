#!/usr/bin/env ruby
require 'rubygems'
require 'bundler'
Bundler.setup

require 'spec_helper'
require 'rspec'
require 'webmock/rspec'

require File.expand_path(File.join(File.dirname(__FILE__), '../lib/dyn-rb.rb'))

Dir['./spec/support/**/*.rb'].each { |f| require f }

RSpec.configure do |config|

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:all) do
    @default_api_key = 1
    @api_base_path = 'https://emailapi.dynect.net/rest/json'

    @dyn = Dyn::Messaging::Client.new(@default_api_key)
  end

end
