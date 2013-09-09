require_relative "test_helper"

class ClientTest < MiniTest::Unit::TestCase
  def setup
    FakeWeb.allow_net_connect = false
    @client_opts = {
      :application_key => "APPLICATION_KEY",
      :secret_key => "SECRET_KEY"
    }

    @client = Dalia::Api::Publisher::Client.new @client_opts
  end

  def test_fetch_surveys
    FakeWeb.register_uri(
      :get,
      "http://daliaresearch.com/api/surveys?device_id=DEVICE_ID&device_id_kind=DEVICE_ID_KIND&access_key=&application_key=APPLICATION_KEY",
      :body => File.read("#{FIXTURES}/fake_responses/fetch_surveys.json"),
      :status => ["200", "Success"]
    )

    response = @client.fetch_surveys(:device_id => "DEVICE_ID", :device_id_kind => "DEVICE_ID_KIND")

    assert_equal(6, response[:surveys].length)
  end

  def test_fetch_survey
    FakeWeb.register_uri(
      :get,
      "http://daliaresearch.com/api/surveys/SURVEY_ID?survey_id=SURVEY_ID&device_id=DEVICE_ID&device_id_kind=DEVICE_ID_KIND&access_key=&application_key=APPLICATION_KEY",
      :body => File.read("#{FIXTURES}/fake_responses/fetch_survey.json"),
      :status => ["200", "Success"]
    )

    response = @client.fetch_survey(:survey_id => "SURVEY_ID", :device_id => "DEVICE_ID", :device_id_kind => "DEVICE_ID_KIND")

    assert_equal(4, response[:survey][:questions].length)
  end

  def test_send_completion
    FakeWeb.register_uri(
      :post,
      "http://daliaresearch.com/api/surveys/SURVEY_ID/completions",
      :body => File.read("#{FIXTURES}/fake_responses/send_completion.json"),
      :parameters => {:survey_id => "SURVEY_ID", :completion => "COMPLETION", :device_id => "DEVICE_ID", :device_id_kind => "DEVICE_ID_KIND"},
      :status => ["200", "Success"]
    )

    response = @client.send_completion(:survey_id => "SURVEY_ID", :completion => "COMPLETION", :device_id => "DEVICE_ID", :device_id_kind => "DEVICE_ID_KIND")

    assert_equal("10", response[:completion][:credits][:amount])
    assert_equal("completed", response[:completion][:state])
  end

  def test_send_prequalification_success
    FakeWeb.register_uri(
      :post,
      "http://daliaresearch.com/api/surveys/SURVEY_ID/prequalification_success",
      :body => File.read("#{FIXTURES}/fake_responses/send_prequalification_success.json"),
      :parameters => {:survey_id => "SURVEY_ID", :device_id => "DEVICE_ID", :device_id_kind => "DEVICE_ID_KIND"},
      :status => ["200", "Success"]
    )

    response = @client.send_prequalification_success(:survey_id => "SURVEY_ID", :device_id => "DEVICE_ID", :device_id_kind => "DEVICE_ID_KIND")

    assert_equal("prequalification_success", response[:completion][:state])
  end

  def test_send_prequalification_success
    FakeWeb.register_uri(
      :post,
      "http://daliaresearch.com/api/surveys/SURVEY_ID/prequalification_fail",
      :body => File.read("#{FIXTURES}/fake_responses/send_prequalification_fail.json"),
      :parameters => {:survey_id => "SURVEY_ID", :device_id => "DEVICE_ID", :device_id_kind => "DEVICE_ID_KIND"},
      :status => ["200", "Success"]
    )

    response = @client.send_prequalification_fail(:survey_id => "SURVEY_ID", :device_id => "DEVICE_ID", :device_id_kind => "DEVICE_ID_KIND")

    assert_equal("prequalification_fail", response[:completion][:state])
  end
end