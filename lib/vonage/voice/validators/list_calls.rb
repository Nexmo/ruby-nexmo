# typed: ignore
# frozen_string_literal: true

module Vonage
  class Voice::Validators::ListCalls < Namespace
    attr_accessor :status, :date_start, :date_end, :page_size, :record_index, :order, :conversation_uuid

    def initialize(params = {})
      @status = params.fetch(:status, nil)
      @date_start = params.fetch(:date_start, nil)
      @date_end = params.fetch(:date_end, nil)
      @page_size = params.fetch(:page_size, nil)
      @record_index = params.fetch(:record_index, nil)
      @order = params.fetch(:order, nil)
      @conversation_uuid = params.fetch(:conversation_uuid, nil)

      after_initialize!(self)
    end

    def after_initialize!(builder)
      validate_params(builder)
    end

    def validate_params(builder)
      if builder.status
        validate_status_param(builder.status)
      end

      if builder.date_start
        validate_date_start_param(builder.date_start)
      end

      if builder.date_end
        validate_date_end_param(builder.date_end)
      end

      if builder.page_size
        validate_page_size_param(builder.page_size)
      end

      if builder.record_index
        validate_record_index_param(builder.record_index)
      end

      if builder.order
        validate_order_param(builder.order)
      end

      if builder.conversation_uuid
        validate_conversation_uuid_param(builder.conversation_uuid)
      end
    end

    def validate_status_param(status)
      valid_status_states = [
        'started', 'ringing', 'answered', 'machine', 'completed',
        'busy', 'cancelled', 'failed', 'rejected', 'timeout',
        'unanswered'
      ]

      raise ClientError.new("Expect 'status' parameter to be a String") unless status.is_a?(String)
      raise ClientError.new("Expect 'status' parameter to be one of: " \
        "#{valid_status_states.map{|state| "\"#{state}\""}.join(',')}"
      ) unless valid_status_states.include?(status)
    end

    def validate_date_start_param(date_start)
      raise ClientError.new("Expect 'date_start' parameter to be a String") unless date_start.is_a?(String)

      begin
        DateTime.iso8601(date_start)
      rescue
        raise ClientError.new("Expect 'date_start' parameter to be in ISO8601 format")
      end
    end

    def validate_date_end_param(date_end)
      raise ClientError.new("Expect 'date_end' parameter to be a String") unless date_end.is_a?(String)

      begin
        DateTime.iso8601(date_end)
      rescue
        raise ClientError.new("Expect 'date_end' parameter to be in ISO8601 format")
      end
    end

    def validate_page_size_param(page_size)
      raise ClientError.new("Expect 'page_size' parameter to be an Integer") unless page_size.is_a?(Integer)
    end

    def validate_record_index_param(record_index)
      raise ClientError.new("Expect 'record_index' parameter to be an Integer") unless record_index.is_a?(Integer)
    end

    def validate_order_param(order_param)
      raise ClientError.new("Expect 'order' parameter to be a String") unless order_param.is_a?(String)
    
      raise ClientError.new("Expect 'order' parameter value to be either 'asc' or 'desc'") unless order_param == 'asc' || order_param == 'desc'
    end

    def validate_conversation_uuid_param(conversation_uuid)
      raise ClientError.new("Expect 'conversation_uuid' parameter to be a String") unless conversation_uuid.is_a?(String)
    end
  end
end