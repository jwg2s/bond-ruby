require_relative './test_helper'

class AccountTest < Minitest::Test
  def test_returns_single_account
    VCR.use_cassette('account') do
      account = Bond::Account.new('UXpj28zjyvQ20exTENfVqm1Ydcy7TjM2')
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
end
