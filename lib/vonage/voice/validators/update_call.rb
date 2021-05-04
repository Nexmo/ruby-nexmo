# typed: ignore
# frozen_string_literal: true

module Vonage
  class Voice::Validators::UpdateCall < Namespace
    attr_accessor :action, :destination

    def initialize(params = {})
      @action = params.fetch(:action)
      @destination = params.fetch(:destination, nil)

      after_initialize!(self)
    end

    def after_initialize!(builder)
      validate_no_params_conflict(builder)
      validate_required_params_data(builder)
    end

    def validate_no_params_conflict(builder)
      if builder.destination && builder.action != 'transfer'
        raise ClientError.new("Expect 'destination' parameter only when the 'action' parameter is 'transfer'")
      end
    end

    def validate_required_params_data(builder)
      validate_action_params(builder.action)
      validate_destination_params(builder.destination) if builder.destination
    end

    def validate_action_params(action_param)
      valid_actions = ['transfer', 'hangup', 'mute', 'unmute', 'earmuff', 'unearmuff']

      raise ClientError.new("Expect 'action' parameter to be a String") unless action_param.is_a?(String)
      raise ClientError.new("Expect 'action' parameter to be one of: " \
        "#{valid_actions.map{|action| "\"#{action}\""}.join(',')}"
      ) unless valid_actions.include?(action_param)
    end

    def validate_destination_params(destination_param)
      raise ClientError.new("Expect 'destination' parameter to be a Hash") unless destination_param.is_a?(Hash)
      raise ClientError.new("Expected 'destination' parameter to only have two keys: 'type' and either 'answer_url' or 'ncco'") if destination_param.keys.count > 2
      raise ClientError.new("Expected a String for the value of 'type'") if !destination_param[:type].is_a?(String)

      if destination_param[:ncco]
        raise ClientError.new("Expected 'ncco' parameter to be an Array") unless destination_param[:ncco].is_a?(Array)
      end
      
      if destination_param[:url]
        raise ClientError.new("Expected 'url' parameter to be an Array") unless destination_param[:url].is_a?(Array)
        raise ClientError.new("Expected only one item in 'url' parameter Array") unless destination_param[:url].length == 1
        raise ClientError.new("Expected item value in 'url' parameter to be a String") unless destination_param[:url][0].is_a?(String)
      end
    end
  end
end