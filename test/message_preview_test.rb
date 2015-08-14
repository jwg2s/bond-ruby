require_relative './test_helper'

class MessagePreviewTest < Minitest::Test
  def test_request_preview
    preview_hash = {
      'content': 'The essence of being human is that one does not seek perfection.',
      'stationery_id': 585426,
      'handwriting': {
        'id': 583811,
        'size': 14
      }
    }

    VCR.use_cassette('get_message_preview') do
      message_preview = Bond::MessagePreview.new(preview_hash)
      message_preview.request_preview

      refute_nil message_preview.encoded_content
      refute_nil message_preview.encoded_content_hash
      refute_nil message_preview.encoded_content_timestamp
      refute_nil message_preview.img
    end
  end
end
