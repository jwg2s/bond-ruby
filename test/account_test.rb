require_relative './test_helper'

class AccountTest < Minitest::Test
  def test_returns_single_account
    VCR.use_cassette('account/success_get_account', :match_requests_on => [:path]) do
      account = Bond::Account.new
      assert_equal Bond::Account, account.class

      # Check that the fields are accessible by our model
      assert_equal 'Contactually', account.first_name
      assert_equal 'Engineering', account.last_name
      assert_equal 'engineering@contactually.com', account.email
      assert_equal 174, account.credits
      assert_equal ({
                     'stationery' => 'https://api.hellobond.com/account/stationery',
                     'handwriting-styles' => 'https://api.hellobond.com/account/handwriting-styles' }
                   ), account.links
    end
  end

  def test_handle_failure
    original_key = Bond.api_key
    VCR.use_cassette('account/failure_get_account', :match_requests_on => [:path]) do
      Bond.api_key = nil
      assert_raises(Bond::BondError) { Bond::Account.new }
    end
    Bond.api_key = original_key
  end
end
