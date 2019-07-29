# frozen_string_literal: true

module WellKnown
  class NodeInfoController < ActionController::Base
    include RoutingHelper

    before_action { response.headers['Vary'] = 'Accept' }

    def index
      render json: {} ,serializer: NodeDiscoverySerializer, root:''
    end

    def show
      render json: {} , serializer: NodeInfoSerializer, version: "2.#{ params[:format] }", root: ''
    end
  end
end
