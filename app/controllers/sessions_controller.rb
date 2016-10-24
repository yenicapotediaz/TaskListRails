class SessionsController < ApplicationController
skip_before_action :require_login, only: [:login, :create]

  def login; end

  def create
    auth_hash = request.env['omniauth.auth']
    redirect_to login_failure_path unless auth_hash['uid']

    @user = User.find_by(uid: auth_hash[:uid], provider: 'github')
    if @user.nil?
      @user = User.build_from_github(auth_hash)
      render :creation_failure unless @user.save
    end

    session[:user_id] = @user.id
    redirect_to tasks_path
  end

  def logout
    session.delete(:user_id)
  end
end
