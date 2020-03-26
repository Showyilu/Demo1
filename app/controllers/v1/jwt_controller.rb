module V1
  class JwtController < ApplicationController
    skip_before_action :authorize_request, only: :auth

    def auth
      result = IssueTokenService.new(
        auth_params[:username],
        auth_params[:password]
      ).run

      render(json: { access_token: result.data })
    end

    private

    def auth_params
      params.permit(:username, :password)
    end
  end
end
