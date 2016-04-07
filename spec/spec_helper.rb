require 'simplecov'
SimpleCov.start

module Omniauth
  def stub_omniauth
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
    provider: 'github',
    uid: "1",
    info: { name: "Nick",
          nickname: "weilandia"},
    credentials: { token: ENV['GITHUB_USER_TOKEN']},
    extra: { raw_info: {
          avatar_url: "https://avatars3.githubusercontent.com/u/13652979?v=3&u=4b2548366e2f82029320102fd434d968efde206b&s=140"}}})
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|

    mocks.verify_partial_doubles = true
  end
  config.include Omniauth
end
