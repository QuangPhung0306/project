class Api::V1::BaseController < ApplicationController
  rescue_from ApiExceptions::BaseException, :with => :render_error_response

  def render_error_response error
    render json: error, serializer: ApiExceptionSerializer, status: 200
  end
end