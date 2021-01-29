require 'simplecov'

SimpleCov.start 'rails'

Dir["#{File.dirname(__FILE__)}/../spec/support/auth/*.rb"].sort.each { |f| require f }
Dir["#{File.dirname(__FILE__)}/../spec/support/*.rb"].sort.each { |f| require f }
Dir["#{File.dirname(__FILE__)}/../spec/support/example_groups/*.rb"].sort.each { |f| require f }

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.include Requests::DisableFlashSweeping, type: :controller
  config.include Requests::JsonHelpers, type: :controller
  config.include Auth::SecurityHelpers, type: :controller

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.order = :random

  config.after(:each) do
    ActiveJob::Base.queue_adapter.enqueued_jobs = []
    ActiveJob::Base.queue_adapter.performed_jobs = []
  end

  Kernel.srand config.seed
end
