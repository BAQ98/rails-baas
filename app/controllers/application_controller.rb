class ApplicationController < ActionController::Base
  include DeviseHelper
  include Pagination
end
