require_relative "test_helper"

class MockClientTest < MiniTest::Unit::TestCase
  def setup
    FakeWeb.allow_net_connect = false

    @client = Dalia::Api::Publisher::MockClient.new
  end

  def test_fetch_surveys
    response = @client.fetch_surveys(:account_id => "PUBLISHER_ACCOUNT_ID_MOCK")

    assert_equal(6, response[:surveys].length)
  end

  def test_fetch_survey
    response = @client.fetch_survey(:account_id => "PUBLISHER_ACCOUNT_ID_MOCK", :survey_id => "SURVEY_ID")

    assert_equal(4, response[:survey][:questions].length)
  end

  def test_send_survey
    response = @client.send_survey(:account_id => "PUBLISHER_ACCOUNT_ID_MOCK", :data => "DATA")

    assert_equal("280", response[:survey][:credits][:amount])
  end

  def test_fetch_completions
    response = @client.fetch_completions(:account_id => "PUBLISHER_ACCOUNT_ID_MOCK", :survey_id => "SURVEY_ID")

    assert_equal(3, response[:completions].length)
  end

  def test_fetch_completion
    response = @client.fetch_completion(:account_id => "PUBLISHER_ACCOUNT_ID_MOCK", :survey_id => "SURVEY_ID", :completion_id => "COMPLETION_ID")

    assert_equal("completed", response[:completion][:state])
  end
end