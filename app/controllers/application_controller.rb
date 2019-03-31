class ApplicationController < ActionController::Base
  include Pundit
  before_action :authenticate_user!, except: [:index, :show]
  after_action :verify_authorized, except: [:index, :show]
end
