require_relative "test_helper"

class ClientTest < MiniTest::Unit::TestCase
  def setup
    FakeWeb.allow_net_connect = false
    @client_opts = {}

    @client = Dalia::Api::Publisher::Client.new @client_opts
  end

  def test_fetch_surveys
    FakeWeb.register_uri(
      :get,
      "http://daliaresearch.com/api/publisher/publisher_users/PUBLISHER_ACCOUNT_ID/surveys",
      :body => File.read("#{FIXTURES}/fake_responses/fetch_surveys.json"),
      :status => ["200", "Success"]
    )

    response = @client.fetch_surveys(:account_id => "PUBLISHER_ACCOUNT_ID")

    assert_equal(6, response[:surveys].length)
  end

  def test_fetch_survey
    FakeWeb.register_uri(
      :get,
      "http://daliaresearch.com/api/publisher/publisher_users/PUBLISHER_ACCOUNT_ID/surveys/SURVEY_ID",
      :body => File.read("#{FIXTURES}/fake_responses/fetch_survey.json"),
      :status => ["200", "Success"]
    )

    response = @client.fetch_survey(:account_id => "PUBLISHER_ACCOUNT_ID", :survey_id => "SURVEY_ID")

    assert_equal(4, response[:survey][:questions].length)
  end

  def test_send_survey
    FakeWeb.register_uri(
      :post,
      "http://daliaresearch.com/api/publisher/publisher_users/PUBLISHER_ACCOUNT_ID/surveys/",
      :body => File.read("#{FIXTURES}/fake_responses/send_survey.json"),
      :parameters => { :data => "DATA" },
      :status => ["200", "Success"]
    )

    response = @client.send_survey(:account_id => "PUBLISHER_ACCOUNT_ID", :data => "DATA")

    assert_equal("280", response[:survey][:credits][:amount])
  end

  def test_update_survey
    FakeWeb.register_uri(
      :put,
      "http://daliaresearch.com/api/publisher/publisher_users/PUBLISHER_ACCOUNT_ID/surveys/SURVEY_ID",
      :body => File.read("#{FIXTURES}/fake_responses/send_survey.json"),
      :parameters => { :survey_id => "SURVEY_ID", :data => "DATA" },
      :status => ["200", "Success"]
    )

    response = @client.update_survey(:account_id => "PUBLISHER_ACCOUNT_ID", :survey_id => "SURVEY_ID", :data => "DATA")

    assert_equal("280", response[:survey][:credits][:amount])
  end

  def test_fetch_completions
    FakeWeb.register_uri(
      :get,
      "http://daliaresearch.com/api/publisher/publisher_users/PUBLISHER_ACCOUNT_ID/surveys/SURVEY_ID/completions",
      :body => File.read("#{FIXTURES}/fake_responses/fetch_completions.json"),
      :status => ["200", "Success"]
    )

    response = @client.fetch_completions(:account_id => "PUBLISHER_ACCOUNT_ID", :survey_id => "SURVEY_ID")

    assert_equal(3, response[:completions].length)
  end

  def test_fetch_completion
    FakeWeb.register_uri(
      :get,
      "http://daliaresearch.com/api/publisher/publisher_users/PUBLISHER_ACCOUNT_ID/surveys/SURVEY_ID/completions/COMPLETION_ID",
      :body => File.read("#{FIXTURES}/fake_responses/fetch_completion.json"),
      :status => ["200", "Success"]
    )

    response = @client.fetch_completion(:account_id => "PUBLISHER_ACCOUNT_ID", :survey_id => "SURVEY_ID", :completion_id => "COMPLETION_ID")

    assert_equal("completed", response[:completion][:state])
  end
end