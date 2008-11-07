require File.dirname(__FILE__) + '/../../test_helper'

# These are tests that should be run if you have 3D secure turned on in the Protx administration panel. these transactions
# will return a status which tells your application to redirect the user to the banks 3D authentication page.
class Remote3DProtxTest < Test::Unit::TestCase
  # Run the tests in the test environment. You must turn 3D secure on in your Protx settings for these to work
  ProtxGateway.simulate = false
  
  def setup
    @gateway = ProtxGateway.new(fixtures(:protx))

    @mastercard = CreditCard.new(
      :number => '5301250070000191',
      :month => 12,
      :year => 2009,
      :verification_value => 419,
      :first_name => 'Longbob',
      :last_name => 'Longsen',
      :type => :master
    )


    @mastercard_options = { 
      :billing_address => { 
        :address1 => '25 The Larches',
        :city => "Narborough",
        :state => "Leicester",
        :zip => 'LE10 2RT'
      },
      :order_id => generate_unique_id,
      :description => 'Store purchase'
    }
  
    @amount = 100
  end

  def test_successful_mastercard_purchase
    assert response = @gateway.purchase(@amount, @mastercard, @mastercard_options)
    assert_failure response
    assert response.test?
    assert !response.authorization.blank?
    assert_equal '3DAUTH', response.params['Status']
    puts response.inspect
  end

end
