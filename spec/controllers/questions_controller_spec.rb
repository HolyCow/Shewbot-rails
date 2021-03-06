require 'spec_helper'
require 'webmock/rspec'

describe QuestionsController do

  describe "POST create" do
    before {
      Settings.live_url = 'http://example.com'
      stub_request(:get, Settings.live_url).to_return(:body => JSON_content())
    }

    describe "with an original question" do
      it "creates a new question" do
        expect {
          request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(create(:api).api_key)
          response = post :create, {format: :json, question: "This is a title", user: "User1", host: "10.10.10.10", username: "User1"}
          puts response.body
        }.to change(Question, :count).by(1)
      end
    end

    describe "with an duplicate question"

  end
end


def JSON_content
  return '{"live":true,"broadcast":{"title":"Amplified","slug":"amplified","show_art":"http://icebox.5by5.tv/images/broadcasts/35/cover.jpg"}}'
end
