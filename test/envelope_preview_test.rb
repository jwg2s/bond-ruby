require_relative './test_helper'

class EnvelopePreviewTest < Minitest::Test
  def test_request_preview
    preview_hash = {
      'recipient_address': {
        'name': 'Napoleon',
        'business_name': 'Animal Farm',
        'address_1': '123 Fake Street',
        'address_2': 'Floor 2',
        'city': 'New York',
        'state': 'NY',
        'zip': '10001'
      },
      'sender_address': {
        'name': 'George Orwell',
        'business_name': '',
        'address_1': '123 Fake Street',
        'address_2': 'Floor 2',
        'city': 'New York',
        'state': 'NY',
        'zip': '10001'
      },
      'stationery_id': 583819,
      'handwriting': {
        'id': 583811,
        'size': 14
      }
    }

    VCR.use_cassette('envelope_preview/success_get_envelope_preview', :match_requests_on => [:path]) do
      envelope_preview = Bond::EnvelopePreview.new(preview_hash)
      envelope_preview.request_preview

      refute_nil envelope_preview.encoded_envelope
      refute_nil envelope_preview.encoded_envelope_hash
      refute_nil envelope_preview.encoded_envelope_timestamp
      refute_nil envelope_preview.img
    end
  end

  def test_failure_request_preview
    VCR.use_cassette('envelope_preview/failure_get_envelope_preview', :match_requests_on => [:path]) do
      envelope_preview = Bond::EnvelopePreview.new
      assert_raises(Bond::BondError) { envelope_preview.request_preview }
    end
  end
end
