module ApiExceptions
  class PurchaseError < ApiExceptions::BaseException
    class MissingDatesError < ApiExceptions::PurchaseError
    end
  end
end