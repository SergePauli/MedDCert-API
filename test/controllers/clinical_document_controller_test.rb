require "test_helper"

class ClinicalDocumentControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get clinical_document_create_url
    assert_response :success
  end

  test "should get update" do
    get clinical_document_update_url
    assert_response :success
  end
end
