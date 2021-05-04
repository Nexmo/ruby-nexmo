# typed: ignore
# frozen_string_literal: true

module Vonage
  class Voice::Validators::CreateCall < Namespace
    attr_accessor :to, :from, :event_url, :event_method, :machine_detection, :length_timer, :ringing_timer, :ncco, :answer_url

    def initialize(params = {})
      @to = params.fetch(:to)
      @from = params.fetch(:from)
      @event_url = params.fetch(:event_url, nil)
      @event_method = params.fetch(:event_method, nil)
      @machine_detection = params.fetch(:machine_detection, nil)
      @length_timer = params.fetch(:length_timer, nil)
      @ringing_timer = params.fetch(:ringing_timer, nil)
      @ncco = params.fetch(:ncco, nil)
      @answer_url = params.fetch(:answer_url, nil)

      after_initialize!(self)
    end

    def after_initialize!(builder)
      validate_no_params_conflict(builder)
      validate_required_params_data(builder)
      validate_optional_params_data(builder)
    end

    def validate_no_params_conflict(builder)
      if builder.ncco && builder.answer_url
        raise ClientError.new("Expected either 'ncco' param or 'answer_url' param, not both")
      end
    end

    def validate_required_params_data(builder)
      validate_to_param(builder.to)
      validate_from_param(builder.from)
      if !builder.ncco && !builder.answer_url
        raise ClientError.new("Expected either 'answer_url' or 'ncco' parameter to be provided")
      end

      if builder.ncco && !builder.answer_url
        validate_ncco_param(builder.ncco)
      end

      if !builder.ncco && builder.answer_url
        validate_answer_url_param(builder.answer_url)
      end
    end

    def validate_optional_params_data(builder)
      if builder.event_url
        validate_event_url_param(builder.event_url)
      end

      if builder.event_method
        validate_event_method_param(builder.event_method)
      end

      if builder.ringing_timer
        validate_ringing_timer_param(builder.ringing_timer)
      end

      if builder.length_timer
        validate_length_timer_param(builder.length_timer)
      end

      if builder.machine_detection
        validate_machine_detection_param(builder.machine_detection)
      end
    end

    def validate_machine_detection_param(machine_detection_param)
      raise ClientError.new("Expected value of 'machine_detection' parameter to be a String") if !machine_detection_param.is_a?(String)
      raise ClientError.new("Expected value of 'machine_detection' parameter to be either 'continue' or 'hangup'") unless machine_detection_param == 'continue' || machine_detection_param == 'hangup'
    end

    def validate_to_param(to_param)
      raise ClientError.new("Expected 'to' parameter to be an Array") if !to_param.is_a?(Array)
      raise ClientError.new("Expected value of 'to' parameter to be a Hash") if !to_param[0].is_a?(Hash)
      raise ClientError.new("Expected 'to' parameter to be an Array of only one value") if to_param.count > 1

      raise ClientError.new("Expected a String for the value of 'type'") if !to_param[0][:type].is_a?(String)
      raise ClientError.new("Expected a String for the value of 'number'") if !to_param[0][:number].is_a?(String)
      raise ClientError.new("Expected 'number' value to be between 7 and 15 digits") if to_param[0][:number].length < 7 || to_param[0][:number].length > 15
      raise ClientError.new("Expected 'dtmfAnswer' value to be a String") if to_param[0][:dtmfAnswer] && !to_param[0][:dtmfAnswer].is_a?(String)
    end

    def validate_from_param(from_param)
      raise ClientError.new("Expected 'from' parameter to be a Hash") if !from_param.is_a?(Hash)
      raise ClientError.new("Expected 'from' parameter to only have two keys: 'type' and 'number'") if from_param.keys.count > 2

      raise ClientError.new("Expected a String for the value of 'type'") if !from_param[:type].is_a?(String)
      raise ClientError.new("Expected a String for the value of 'number'") if !from_param[:number].is_a?(String)
      raise ClientError.new("Expected 'number' value to be between 7 and 15 digits") if from_param[:number].length < 7 || from_param[:number].length > 15
    end

    def validate_ncco_param(ncco_param)
      raise ClientError.new("Expected 'ncco' parameter to be an Array") if !ncco_param.is_a?(Array)
      raise ClientError.new("Expected value of 'ncco' parameter to be a Hash") if !ncco_param[0].is_a?(Hash)
    end

    def validate_answer_url_param(answer_url_param)
      raise ClientError.new("Expected 'answer_url' parameter to be an Array") if !answer_url_param.is_a?(Array)
      raise ClientError.new("Expected value of 'answer_url' parameter to be a String") if !answer_url_param[0].is_a?(String)
      raise ClientError.new("Expected only one String value of 'answer_url' parameter") if answer_url_param.count > 1
    end

    def validate_event_url_param(event_url_param)
      raise ClientError.new("Expected 'event_url' parameter to be an Array") if !event_url_param.is_a?(Array)
      raise ClientError.new("Expected value of 'event_url' parameter to be a String") if !event_url_param[0].is_a?(String)
      raise ClientError.new("Expected only one String value of 'event_url' parameter") if event_url_param.count > 1
    end

    def validate_event_method_param(event_method_param)
      raise ClientError.new("Expected value of 'event_method' parameter to be a String") if !event_method_param.is_a?(String)
      raise ClientError.new("Expected value of 'event_method' parameter to be either 'GET' or 'POST'") unless event_method_param == 'GET' || event_method_param == 'POST'
    end

    def validate_ringing_timer_param(ringing_timer_param)
      raise ClientError.new("Expected 'ringing_timer' parameter to be an Integer") if !ringing_timer_param.is_a?(Integer)
      raise ClientError.new("Expected 'ringing_timer' parameter to be between 1 and 120") if ringing_timer_param < 1 || ringing_timer_param > 120
    end

    def validate_length_timer_param(length_timer_param)
      raise ClientError.new("Expected 'length_timer' parameter to be an Integer") if !length_timer_param.is_a?(Integer)
      raise ClientError.new("Expected 'length_timer' parameter to be between 1 and 7200") if length_timer_param < 1 || length_timer_param > 7200
    end
  end
end