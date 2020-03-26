class BaseService
  SERVICE_STATUS_SUCCESS = "service_success".freeze
  SERVICE_STATUS_ERROR = "service_error".freeze

  attr_accessor :current_user, :params

  def initialize(user = nil, params = {})
    @current_user = user
    @params = params.dup
    @params = @params.with_indifferent_access if @params.is_a? Hash
  end

  def success(data = {})
    result = OpenStruct.new(
      data: data,
      status: SERVICE_STATUS_SUCCESS,
      success?: true
    )

    result
  end

  def error(message = nil, data = {}, http_status = nil)
    result = OpenStruct.new(
      data: data,
      message: message,
      status: SERVICE_STATUS_ERROR,
      success?: false
    )

    result.http_status = http_status if http_status
    result
  end
end
