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
end
