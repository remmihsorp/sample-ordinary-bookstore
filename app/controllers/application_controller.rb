class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper
  include UsersHelper
  include SqlHelper
  include OrdersHelper
  include OrderItemsHelper
  include BooksHelper
  include ReviewRatingsHelper
end
