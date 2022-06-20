module Requests
  module JsonHelpers
    def json
      JSON.parse(response.body)
    end

    def expect_valid_json_response
      expect(response.status).to be 200
      expect(response.content_type).to eq('application/json')
      expect(json.size).not_to be_nil
    end
  end
end