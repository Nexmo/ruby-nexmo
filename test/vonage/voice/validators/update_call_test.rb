# typed: false

class Vonage::Voice::Validators::UpdateCallTest < Vonage::Test
  def test_with_required_params_action_and_destination
    params = {
      action: 'transfer',
      destination: {type: 'ncco', ncco: [{action: 'talk', text: 'test text'}]}
    }
    builder = Vonage::Voice::Validators::UpdateCall.new(params)

    assert_equal builder.action, params[:action]
    assert_equal builder.destination, params[:destination]
  end

  def test_with_required_params_only_action
    params = {
      action: 'hangup'
    }
    builder = Vonage::Voice::Validators::UpdateCall.new(params)

    assert_equal builder.action, params[:action]
    assert_nil builder.destination
  end

  def test_with_params_conflict
    params = {
      action: 'hangup',
      destination: {type: 'ncco', ncco: [{action: 'talk', text: 'test text'}]}
    }

    exception = assert_raises { Vonage::Voice::Validators::UpdateCall.new(params) }

    assert_match "Expect 'destination' parameter only when the 'action' parameter is 'transfer'", exception.message
  end

  def test_action_param_incorrect_object_type
    params = {
      action: ['hangup']
    }

    exception = assert_raises { Vonage::Voice::Validators::UpdateCall.new(params) }

    assert_match "Expect 'action' parameter to be a String", exception.message
  end

  def test_action_param_raise_incorrect_value
    params = {
      action: 'pause'
    }

    exception = assert_raises { Vonage::Voice::Validators::UpdateCall.new(params) }

    assert_match "Expect 'action' parameter to be one of: \"transfer\",\"hangup\",\"mute\",\"unmute\",\"earmuff\",\"unearmuff\"", exception.message
  end

  def test_destination_param_incorrect_object_type
    params = {
      action: 'transfer',
      destination: [{type: 'ncco', ncco: [{action: 'talk', text: 'test text'}]}]
    }

    exception = assert_raises { Vonage::Voice::Validators::UpdateCall.new(params) }

    assert_match "Expect 'destination' parameter to be a Hash", exception.message
  end

  def test_destination_param_incorrect_number_of_keys
    params = {
      action: 'transfer',
      destination: {type: 'ncco', ncco: [{action: 'talk', text: 'test text'}], third_key: 'too many keys'}
    }

    exception = assert_raises { Vonage::Voice::Validators::UpdateCall.new(params) }

    assert_match "Expected 'destination' parameter to only have two keys: 'type' and either 'answer_url' or 'ncco'", exception.message
  end

  def test_destination_param_type_field_object_type
    params = {
      action: 'transfer',
      destination: {type: 3, ncco: [{action: 'talk', text: 'test text'}]}
    }

    exception = assert_raises { Vonage::Voice::Validators::UpdateCall.new(params) }

    assert_match "Expected a String for the value of 'type'", exception.message
  end

  def test_destination_param_with_ncco_field
    params = {
      action: 'transfer',
      destination: {type: 'ncco', ncco: {action: 'talk', text: 'test text'}}
    }

    exception = assert_raises { Vonage::Voice::Validators::UpdateCall.new(params) }

    assert_match "Expected 'ncco' parameter to be an Array", exception.message
  end

  def test_destination_param_with_url_field_wrong_type
    params = {
      action: 'transfer',
      destination: {type: 'ncco', url: 'https://example.com/transfer'}
    }

    exception = assert_raises { Vonage::Voice::Validators::UpdateCall.new(params) }

    assert_match "Expected 'url' parameter to be an Array", exception.message
  end

  def test_destination_param_with_url_field_too_many_items
    params = {
      action: 'transfer',
      destination: {type: 'ncco', url: ['https://example.com/transfer', 'second item']}
    }

    exception = assert_raises { Vonage::Voice::Validators::UpdateCall.new(params) }

    assert_match "Expected only one item in 'url' parameter Array", exception.message
  end

  def test_destination_param_with_url_field_wrong_type_for_item
    params = {
      action: 'transfer',
      destination: {type: 'ncco', url: [12345]}
    }

    exception = assert_raises { Vonage::Voice::Validators::UpdateCall.new(params) }

    assert_match "Expected item value in 'url' parameter to be a String", exception.message
  end
end