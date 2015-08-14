require_relative './test_helper'

class PreviewTest < Minitest::Test
  def test_get_preview
    preview_hash = {
      'content': 'The essence of being human is that one does not seek perfection.',
      'stationery_id': 585426,
      'handwriting': {
        'id': 583811,
        'size': 14
      }
    }

    VCR.use_cassette('get_preview') do
      preview = Bond::Preview.new(preview_hash)
      preview.request_preview

      refute_nil preview.encoded_content
      refute_nil preview.encoded_content_hash
      refute_nil preview.encoded_content_timestamp
      refute_nil preview.img
    end
  end
end
