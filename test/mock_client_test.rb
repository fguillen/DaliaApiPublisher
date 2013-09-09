require_relative "test_helper"

class MockClientTest < MiniTest::Unit::TestCase
  def setup
    FakeWeb.allow_net_connect = false
  end

  def test_fetch_surveys
    client = Dalia::Api::Publisher::MockClient.new

    response = client.fetch_surveys(:device_id => "DEVICE_ID", :device_id_kind => "DEVICE_ID_KIND")

    assert_equal(6, response[:surveys].length)
  end

  def test_fetch_survey
    client = Dalia::Api::Publisher::MockClient.new

    response = client.fetch_survey(:survey_id => "SURVEY_ID_MOCK", :device_id => "DEVICE_ID", :device_id_kind => "DEVICE_ID_KIND")

    assert_equal(4, response[:survey][:questions].length)
  end

  def test_send_completion
    client = Dalia::Api::Publisher::MockClient.new

    response = client.send_completion(:survey_id => "SURVEY_ID_MOCK", :completion => "COMPLETION", :device_id => "DEVICE_ID", :device_id_kind => "DEVICE_ID_KIND")

    assert_equal("10", response[:completion][:credits][:amount])
    assert_equal("completed", response[:completion][:state])
  end

  def test_send_prequalification_success
    client = Dalia::Api::Publisher::MockClient.new

    response = client.send_prequalification_success(:survey_id => "SURVEY_ID_MOCK", :device_id => "DEVICE_ID", :device_id_kind => "DEVICE_ID_KIND")

    assert_equal("prequalification_success", response[:completion][:state])
  end

  def test_send_prequalification_fail
    client = Dalia::Api::Publisher::MockClient.new

    response = client.send_prequalification_fail(:survey_id => "SURVEY_ID_MOCK", :device_id => "DEVICE_ID", :device_id_kind => "DEVICE_ID_KIND")

    assert_equal("prequalification_fail", response[:completion][:state])
  end
end