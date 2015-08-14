require_relative './test_helper'

class MessagePreviewTest < Minitest::Test
  def test_request_preview
    preview_hash = {
      'content': 'The essence of being human is that one does not seek perfection.',
      'stationery_id': 583819,
      'handwriting': {
        'id': 583811,
        'size': 14
      }
    }

    VCR.use_cassette('message_preview/success_get_message_preview', :match_requests_on => [:path]) do
      message_preview = Bond::MessagePreview.new(preview_hash)
      message_preview.request_preview

      refute_nil message_preview.encoded_content
      refute_nil message_preview.encoded_content_hash
      refute_nil message_preview.encoded_content_timestamp
      refute_nil message_preview.img
    end
  end

  def test_invalid_request_preview
    VCR.use_cassette('message_preview/failure_get_message_preview', :match_requests_on => [:path]) do
      message_preview = Bond::MessagePreview.new
      assert_raises(Bond::BondError) { message_preview.request_preview }
    end
  end
end
