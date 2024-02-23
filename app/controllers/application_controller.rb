# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include DeviseHelper
  include Pagination
  include Authorization
end
