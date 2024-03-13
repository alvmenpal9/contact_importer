require 'rails_helper'

RSpec.describe "Imports", type: :request do
  describe "POST /imports" do
    context "when fields are valid" do
      it "creates the import" do
        file = fixture_file_upload("example.csv", "text/csv")
        post "/api/v1/imports", params: {file:file}
        expect(response).to have_http_status(200)
      end
    end
  end
end
