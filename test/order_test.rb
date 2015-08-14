require_relative './test_helper'

class OrderTest < Minitest::Test
  def test_returns_all_orders
    VCR.use_cassette('orders') do
      orders = Bond::Order.all
      order = orders.first
      assert_equal '54f0-b9d4-947e-7', order.guid
      assert_equal '2015-01-01 12:00:00', order.created_at
      assert_equal 'complete', order.status
      assert_equal ([{ 'id' => 1,
                       'type' => 'stationery',
                       'name' => 'Big Brother is Watching',
                       'quantity' => 1,
                       'price' => 2.99,
                       'total' => 2.99 }]), order.products
      assert_equal ({ 'total' => 0.49 }), order.shipping
      assert_equal 3.48, order.total
      assert_equal ({ 'messages' => 'https://api.hellobond.com/orders/54f0-b9d4-947e-7/messages' }), order.links
    end
  end

  def test_return_single_order
    VCR.use_cassette('order') do
      order = Bond::Order.find(1)
      assert_equal '54f0-b9d4-947e-7', order.guid
      assert_equal '2015-01-01 12:00:00', order.created_at
      assert_equal 'complete', order.status
      assert_equal ([{ 'id' => 1,
                       'type' => 'stationery',
                       'name' => 'Big Brother is Watching',
                       'quantity' => 1,
                       'price' => 2.99,
                       'total' => 2.99 }]), order.products
      assert_equal ({ 'total' => 0.49 }), order.shipping
      assert_equal 3.48, order.total
    end
  end

  def test_create_single_order
    VCR.use_cassette('create_order') do
      order = Bond::Order.create
      assert_equal '55cd-e138-32dc-7', order.guid
      assert_equal '2015-08-14 12:38:16', order.created_at
    end
  end

  def test_process_single_order
    VCR.use_cassette('process_order') do
      order = Bond::Order.create
      order.process
      assert_equal '2015-08-14 12:48:20', order.created_at
      assert_equal '55cd-e394-63aa-f', order.guid
      assert_equal ({ 'self' => 'https://api.hellobond.com/orders/55cd-e394-63aa-f',
                      'messages' => 'https://api.hellobond.com/orders/55cd-e394-63aa-f/messages' }), order.links
    end
  end

  def test_add_and_retrieve_message
    VCR.use_cassette('add_messages_to_order') do
      message_preview = Bond::MessagePreview.new(
        'content': 'The essence of being human is that one does not seek perfection.',
        'stationery_id': 583819,
        'handwriting': {
          'id': 583811,
          'size': 14
        }
      )
      message_preview.request_preview

      envelope_preview = Bond::EnvelopePreview.new(
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
      )

      envelope_preview.request_preview

      message_hash = {
        'stationery_id': 583819,
        'handwriting': {
          'id': 583811,
          'size': 14
        },
        'content': 'The essence of being human is that one does not seek perfection.',
        'encoded_content': message_preview.encoded_content,
        'encoded_content_hash': message_preview.encoded_content_hash,
        'encoded_content_timestamp': message_preview.encoded_content_timestamp,
        'encoded_envelope': envelope_preview.encoded_envelope,
        'encoded_envelope_hash': envelope_preview.encoded_envelope_hash,
        'encoded_envelope_timestamp': envelope_preview.encoded_envelope_timestamp,
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
        }
      }

      order = Bond::Order.create
      assert_equal true, order.add_message(message_hash)

      order.process

      assert_equal 1, order.messages.count
    end
  end
end
