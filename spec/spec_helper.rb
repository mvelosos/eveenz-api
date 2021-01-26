require 'simplecov'

SimpleCov.start 'rails'

Dir["#{File.dirname(__FILE__)}/../spec/support/*.rb"].sort.each { |f| require f }

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.include Requests::DisableFlashSweeping, type: :controller
  config.include Requests::JsonHelpers, type: :controller

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.order = :random

  Kernel.srand config.seed
end
