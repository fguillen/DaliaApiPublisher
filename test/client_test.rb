require_relative "test_helper"

class ClientTest < MiniTest::Unit::TestCase
  def setup
    FakeWeb.allow_net_connect = false
    @client_opts = {}

    @client = Dalia::Api::Researcher::Client.new @client_opts
  end

  def test_fetch_surveys
    FakeWeb.register_uri(
      :get,
      "http://daliaresearch.com/api/researcher/researcher_users/RESEARCHER_ACCOUNT_ID/surveys",
      :body => File.read("#{FIXTURES}/fake_responses/fetch_surveys.json"),
      :status => ["200", "Success"]
    )

    response = @client.fetch_surveys(:account_id => "RESEARCHER_ACCOUNT_ID")

    assert_equal(6, response[:surveys].length)
  end

  def test_fetch_survey
    FakeWeb.register_uri(
      :get,
      "http://daliaresearch.com/api/researcher/researcher_users/RESEARCHER_ACCOUNT_ID/surveys/SURVEY_ID",
      :body => File.read("#{FIXTURES}/fake_responses/fetch_survey.json"),
      :status => ["200", "Success"]
    )

    response = @client.fetch_survey(:account_id => "RESEARCHER_ACCOUNT_ID", :survey_id => "SURVEY_ID")

    assert_equal(4, response[:survey][:questions].length)
  end

  def test_send_survey
    FakeWeb.register_uri(
      :post,
      "http://daliaresearch.com/api/researcher/researcher_users/RESEARCHER_ACCOUNT_ID/surveys/",
      :body => File.read("#{FIXTURES}/fake_responses/send_survey.json"),
      :parameters => { :data => "DATA" },
      :status => ["200", "Success"]
    )

    response = @client.send_survey(:account_id => "RESEARCHER_ACCOUNT_ID", :data => "DATA")

    assert_equal("280", response[:survey][:credits][:amount])
  end

  def test_update_survey
    FakeWeb.register_uri(
      :put,
      "http://daliaresearch.com/api/researcher/researcher_users/RESEARCHER_ACCOUNT_ID/surveys/SURVEY_ID",
      :body => File.read("#{FIXTURES}/fake_responses/send_survey.json"),
      :parameters => { :survey_id => "SURVEY_ID", :data => "DATA" },
      :status => ["200", "Success"]
    )

    response = @client.update_survey(:account_id => "RESEARCHER_ACCOUNT_ID", :survey_id => "SURVEY_ID", :data => "DATA")

    assert_equal("280", response[:survey][:credits][:amount])
  end

  def test_fetch_completions
    FakeWeb.register_uri(
      :get,
      "http://daliaresearch.com/api/researcher/researcher_users/RESEARCHER_ACCOUNT_ID/surveys/SURVEY_ID/completions",
      :body => File.read("#{FIXTURES}/fake_responses/fetch_completions.json"),
      :status => ["200", "Success"]
    )

    response = @client.fetch_completions(:account_id => "RESEARCHER_ACCOUNT_ID", :survey_id => "SURVEY_ID")

    assert_equal(3, response[:completions].length)
  end

  def test_fetch_completion
    FakeWeb.register_uri(
      :get,
      "http://daliaresearch.com/api/researcher/researcher_users/RESEARCHER_ACCOUNT_ID/surveys/SURVEY_ID/completions/COMPLETION_ID",
      :body => File.read("#{FIXTURES}/fake_responses/fetch_completion.json"),
      :status => ["200", "Success"]
    )

    response = @client.fetch_completion(:account_id => "RESEARCHER_ACCOUNT_ID", :survey_id => "SURVEY_ID", :completion_id => "COMPLETION_ID")

    assert_equal("completed", response[:completion][:state])
  end

  def test_fetch_survey_price
    FakeWeb.register_uri(
      :post,
      "http://daliaresearch.com/api/researcher/researcher_users/RESEARCHER_ACCOUNT_ID/surveys/price",
      :body => File.read("#{FIXTURES}/fake_responses/fetch_survey_price.json"),
      :status => ["200", "Success"]
    )

    response = @client.fetch_survey_price(:account_id => "RESEARCHER_ACCOUNT_ID")

    assert_equal(0.07, response[:price][:total])
  end

  def test_create_query
    FakeWeb.register_uri(
      :get,
      "http://daliaresearch.com/api/researcher/researcher_users/RESEARCHER_ACCOUNT_ID/surveys/SURVEY_ID/query?question_id=QUESTION_ID",
      :body => File.read("#{FIXTURES}/fake_responses/create_query.json"),
      :status => ["200", "Success"]
    )

    response = @client.create_query(:account_id => "RESEARCHER_ACCOUNT_ID", :survey_id => "SURVEY_ID", :question_id => "QUESTION_ID")

    assert_equal("Qb5faf2", response[:question_id])
  end
end