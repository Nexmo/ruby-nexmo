# typed: false
# frozen_string_literal: true

module Nexmo
  class Verify < Namespace
    alias_method :http_request, :request

    private :http_request

    self.response_class = Response

    # Generate and send a PIN to your user.
    #
    # @note You can make a maximum of one Verify request per second.
    #
    # @example
    #   response = client.verify.request(number: '447700900000', brand: 'Acme Inc')
    #
    #   if response.success?
    #     puts "Started verification request_id=#{response.request_id}"
    #   else
    #     puts "Error: #{response.error_text}"
    #   end
    #
    # @option params [required, String] :number
    #   The mobile or landline phone number to verify.
    #   Unless you are setting **:country** explicitly, this number must be in E.164 format.
    #
    # @option params [String] :country
    #   If you do not provide **:number** in international format or you are not sure if **:number** is correctly formatted, specify the two-character country code in **:country**.
    #   Verify will then format the number for you.
    #
    # @option params [required, String] :brand
    #   An 18-character alphanumeric string you can use to personalize the verification request SMS body, to help users identify your company or application name.
    #   For example: "Your `Acme Inc` PIN is ..."
    #
    # @option params [String] :sender_id
    #   An 11-character alphanumeric string that represents the [identity of the sender](https://developer.nexmo.com/messaging/sms/guides/custom-sender-id) of the verification request.
    #   Depending on the destination of the phone number you are sending the verification SMS to, restrictions might apply.
    #
    # @option params [Integer] :code_length
    #   The length of the verification code.
    #
    # @option params [String] :lg
    #   By default, the SMS or text-to-speech (TTS) message is generated in the locale that matches the **:number**.
    #   For example, the text message or TTS message for a `33*` number is sent in French.
    #   Use this parameter to explicitly control the language, accent and gender used for the Verify request.
    #
    # @option params [Integer] :pin_expiry
    #   How log the generated verification code is valid for, in seconds.
    #   When you specify both **:pin_expiry** and **:next_event_wait** then **:pin_expiry** must be an integer multiple of **:next_event_wait** otherwise **:pin_expiry** is defaulted to equal **:next_event_wait**.
    #   See [changing the event timings](https://developer.nexmo.com/verify/guides/changing-default-timings).
    #
    # @option params [Integer] :next_event_wait
    #   Specifies the wait time in seconds between attempts to deliver the verification code.
    #
    # @option params [Integer] :workflow_id
    #   Selects the predefined sequence of SMS and TTS (Text To Speech) actions to use in order to convey the PIN to your user.
    #   For example, an id of 1 identifies the workflow SMS - TTS - TTS.
    #   For a list of all workflows and their associated ids, please visit the [developer portal](https://developer.nexmo.com/verify/guides/workflows-and-events).
    #
    # @param [Hash] params
    #
    # @return [Response]
    #
    # @see https://developer.nexmo.com/api/verify#verifyRequest
    #
    def request(params)
      http_request('/verify/json', params: params, type: Post)
    end

    # Confirm that the PIN you received from your user matches the one sent by Nexmo in your verification request.
    #
    # @example
    #   response = client.verify.check(request_id: request_id, code: '1234')
    #
    #   if response.success?
    #     puts "Verification complete, event_id=#{response.event_id}"
    #   else
    #     puts "Error: #{response.error_text}"
    #   end
    #
    # @option params [required, String] :request_id
    #   The Verify request to check.
    #   This is the `request_id` you received in the response to the Verify request.
    #
    # @option params [required, String] :code
    #   The verification code entered by your user.
    #
    # @option params [String] :ip_address
    #   The IP address used by your user when they entered the verification code.
    #   Nexmo uses this information to identify fraud and spam. This ultimately benefits all Nexmo customers.
    #
    # @param [Hash] params
    #
    # @return [Response]
    #
    # @see https://developer.nexmo.com/api/verify#verifyCheck
    #
    def check(params)
      http_request('/verify/check/json', params: params, type: Post)
    end

    # Check the status of past or current verification requests.
    #
    # @example
    #   response = client.verify.search(request_id: request_id)
    #
    # @option params [String] :request_id
    #   The `request_id` you received in the Verify Request Response.
    #
    # @option params [Array<string>] :request_ids
    #   More than one `request_id`.
    #   Each `request_id` is a new parameter in the Verify Search request.
    #
    # @param [Hash] params
    #
    # @return [Response]
    #
    # @see https://developer.nexmo.com/api/verify#verifySearch
    #
    def search(params)
      http_request('/verify/search/json', params: params)
    end

    # Control the progress of your verification requests.
    #
    # @example
    #   response = client.verify.control(request_id: request_id, cmd: 'cancel')
    #
    # @option params [required, String] :request_id
    #   The `request_id` you received in the response to the Verify request.
    #
    # @option params [required, String] :cmd
    #   The command to execute, depending on whether you want to cancel the verification process, or advance to the next verification event.
    #   You must wait at least 30 seconds before cancelling a Verify request.
    #
    # @param [Hash] params
    #
    # @return [Response]
    #
    # @see https://developer.nexmo.com/api/verify#verifyControl
    #
    def control(params)
      http_request('/verify/control/json', params: params, type: Post)
    end

    # Cancel an existing verification request.
    #
    # @example
    #   response = client.verify.cancel(request_id)
    #
    # @param [String] id
    #
    # @return [Response]
    #
    # @see https://developer.nexmo.com/api/verify#verifyControl
    #
    def cancel(id)
      control(request_id: id, cmd: 'cancel')
    end

    # Trigger the next verification event for an existing verification request.
    #
    # @example
    #   response = client.verify.trigger_next_event(request_id)
    #
    # @param [String] id
    #
    # @return [Response]
    #
    # @see https://developer.nexmo.com/api/verify#verifyControl
    #
    def trigger_next_event(id)
      control(request_id: id, cmd: 'trigger_next_event')
    end
  end
end
