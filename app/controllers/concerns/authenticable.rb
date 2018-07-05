module Authenticable
  # Devise methods overwrites
  def current_user
    @current_user ||= User.find_by(api_token: request.headers['X-Api-Token'], email: request.headers['X-User-Email'])
  end

  def authenticate_with_token!
    render json: { errors: "Not authenticated" },
                status: :unauthorized unless current_user.present?
  end
end
