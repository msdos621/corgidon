# frozen_string_literal: true

class ErrorsController < ApplicationController

  def show
    respond_with_error(params[:code])
  end
end
