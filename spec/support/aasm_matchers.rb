# spec/support/aasm_matchers.rb
puts 'Loading aasm_matchers.'
RSpec.configure do |config|
  config.include AASM::RSpec::Matchers
end
