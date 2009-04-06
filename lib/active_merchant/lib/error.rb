module ActiveMerchant #:nodoc:
  class ActiveMerchantError < StandardError #:nodoc:
  end
  
  class ThreeDSecureRequired < ActiveMerchantError #:nodoc:
  end
end