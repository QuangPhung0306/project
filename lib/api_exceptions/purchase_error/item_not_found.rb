module ApiExceptions
  class PurchaseError < ApiExceptions::BaseException
    class ItemNotFound < ApiExceptions::PurchaseError
    end
  end
end
