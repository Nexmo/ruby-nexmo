# typed: false

class Vonage::Voice::Validators::CreateCallTest < Vonage::Test
  def test_with_only_required_params_and_answer_url
    params = {
      to: [{type: 'phone', number: '14843331234'}],
      from: {type: 'phone', number: '14843335555'},
      answer_url: ['https://example.com/answer']
    }
    builder = Vonage::Voice::Validators::CreateCall.new(params)

    assert_equal builder.to, params[:to]
    assert_equal builder.from, params[:from]
    assert_equal builder.answer_url, params[:answer_url]
  end

  def test_with_only_required_params_and_ncco
    params = {
      to: [{type: 'phone', number: '14843331234'}],
      from: {type: 'phone', number: '14843335555'},
      ncco: [{action: 'talk', text: 'test text'}]
    }
    builder = Vonage::Voice::Validators::CreateCall.new(params)

    assert_equal builder.to, params[:to]
    assert_equal builder.from, params[:from]
    assert_equal builder.ncco, params[:ncco]
  end

  def test_with_missing_to_param
    params = {
      from: {type: 'phone', number: '14843335555'},
      answer_url: ['https://example.com/answer']
    }
        
    exception = assert_raises { Vonage::Voice::Validators::CreateCall.new(params) }

    assert_match "key not found: :to", exception.message
  end

  def test_with_missing_from_param
    params = {
      to: [{type: 'phone', number: '14843331234'}],
      ncco: [{action: 'talk', text: 'test text'}]
    }
        
    exception = assert_raises { Vonage::Voice::Validators::CreateCall.new(params) }

    assert_match "key not found: :from", exception.message
  end

  def test_with_missing_ncco_and_answer_url_param
    params = {
      to: [{type: 'phone', number: '14843331234'}],
      from: {type: 'phone', number: '14843335555'}
    }

    exception = assert_raises { Vonage::Voice::Validators::CreateCall.new(params) }

    assert_match "Expected either 'answer_url' or 'ncco' parameter to be provided", exception.message
  end

  def test_with_required_params_and_both_answer_url_and_ncco
    params = {
      to: [{type: 'phone', number: '14843331234'}],
      from: {type: 'phone', number: '14843335555'},
      ncco: [{action: 'talk', text: 'test text'}],
      answer_url: ['https://example.com/answer']
    }

    exception = assert_raises { Vonage::Voice::Validators::CreateCall.new(params) }

    assert_match "Expected either 'ncco' param or 'answer_url' param, not both", exception.message    
  end

  def test_with_event_url_param
    params = {
      to: [{type: 'phone', number: '14843331234'}],
      from: {type: 'phone', number: '14843335555'},
      ncco: [{action: 'talk', text: 'test text'}],
      event_url: ['https://example.com/event']
    }

    builder = Vonage::Voice::Validators::CreateCall.new(params)

    assert_equal builder.event_url, params[:event_url]
    assert_kind_of Array, builder.event_url
    assert_kind_of String, builder.event_url[0]
    assert builder.event_url.length == 1
  end

  def test_with_event_url_wrong_object_type
    params = {
      to: [{type: 'phone', number: '14843331234'}],
      from: {type: 'phone', number: '14843335555'},
      ncco: [{action: 'talk', text: 'test text'}],
      event_url: 'https://example.com/event'
    }

    exception = assert_raises { Vonage::Voice::Validators::CreateCall.new(params) }

    assert_match "Expected 'event_url' parameter to be an Array", exception.message 
  end

  def test_with_event_url_wrong_item_type
    params = {
      to: [{type: 'phone', number: '14843331234'}],
      from: {type: 'phone', number: '14843335555'},
      ncco: [{action: 'talk', text: 'test text'}],
      event_url: [{url: 'https://example.com/event'}]
    }

    exception = assert_raises { Vonage::Voice::Validators::CreateCall.new(params) }

    assert_match "Expected value of 'event_url' parameter to be a String", exception.message 
  end

  def test_with_event_url_wrong_array_size
    params = {
      to: [{type: 'phone', number: '14843331234'}],
      from: {type: 'phone', number: '14843335555'},
      ncco: [{action: 'talk', text: 'test text'}],
      event_url: ['https://example.com/event', 'https://example.com/event_two']
    }

    exception = assert_raises { Vonage::Voice::Validators::CreateCall.new(params) }

    assert_match "Expected only one String value of 'event_url' parameter", exception.message 
  end

  def test_with_event_method
    params = {
      to: [{type: 'phone', number: '14843331234'}],
      from: {type: 'phone', number: '14843335555'},
      ncco: [{action: 'talk', text: 'test text'}],
      event_method: 'GET'
    }

    builder = Vonage::Voice::Validators::CreateCall.new(params)

    assert_equal builder.event_method, params[:event_method]
    assert_kind_of String, builder.event_method
  end

  def test_with_event_method_wrong_object_type
    params = {
      to: [{type: 'phone', number: '14843331234'}],
      from: {type: 'phone', number: '14843335555'},
      ncco: [{action: 'talk', text: 'test text'}],
      event_method: ['GET']
    }

    exception = assert_raises { Vonage::Voice::Validators::CreateCall.new(params) }

    assert_match "Expected value of 'event_method' parameter to be a String", exception.message 
  end

  def test_with_event_method_wrong_value
    params = {
      to: [{type: 'phone', number: '14843331234'}],
      from: {type: 'phone', number: '14843335555'},
      ncco: [{action: 'talk', text: 'test text'}],
      event_method: 'PUT'
    }

    exception = assert_raises { Vonage::Voice::Validators::CreateCall.new(params) }

    assert_match "Expected value of 'event_method' parameter to be either 'GET' or 'POST'", exception.message 
  end

  def test_with_ringing_timer_param
    params = {
      to: [{type: 'phone', number: '14843331234'}],
      from: {type: 'phone', number: '14843335555'},
      ncco: [{action: 'talk', text: 'test text'}],
      ringing_timer: 30
    }

    builder = Vonage::Voice::Validators::CreateCall.new(params)

    assert_equal builder.ringing_timer, params[:ringing_timer]
    assert_kind_of Integer, builder.ringing_timer
  end

  def test_with_ringing_timer_wrong_object_type
    params = {
      to: [{type: 'phone', number: '14843331234'}],
      from: {type: 'phone', number: '14843335555'},
      ncco: [{action: 'talk', text: 'test text'}],
      ringing_timer: 'thirty'
    }

    exception = assert_raises { Vonage::Voice::Validators::CreateCall.new(params) }

    assert_match "Expected 'ringing_timer' parameter to be an Integer", exception.message 
  end

  def test_with_ringing_timer_too_small_value
    params = {
      to: [{type: 'phone', number: '14843331234'}],
      from: {type: 'phone', number: '14843335555'},
      ncco: [{action: 'talk', text: 'test text'}],
      ringing_timer: 0
    }

    exception = assert_raises { Vonage::Voice::Validators::CreateCall.new(params) }

    assert_match "Expected 'ringing_timer' parameter to be between 1 and 120", exception.message 
  end

  def test_with_ringing_timer_too_large_value
    params = {
      to: [{type: 'phone', number: '14843331234'}],
      from: {type: 'phone', number: '14843335555'},
      ncco: [{action: 'talk', text: 'test text'}],
      ringing_timer: 121
    }

    exception = assert_raises { Vonage::Voice::Validators::CreateCall.new(params) }

    assert_match "Expected 'ringing_timer' parameter to be between 1 and 120", exception.message 
  end

  def test_with_length_timer_param
    params = {
      to: [{type: 'phone', number: '14843331234'}],
      from: {type: 'phone', number: '14843335555'},
      ncco: [{action: 'talk', text: 'test text'}],
      length_timer: 30
    }

    builder = Vonage::Voice::Validators::CreateCall.new(params)

    assert_equal builder.length_timer, params[:length_timer]
    assert_kind_of Integer, builder.length_timer
  end

  def test_with_length_timer_wrong_object_type
    params = {
      to: [{type: 'phone', number: '14843331234'}],
      from: {type: 'phone', number: '14843335555'},
      ncco: [{action: 'talk', text: 'test text'}],
      length_timer: 'thirty'
    }

    exception = assert_raises { Vonage::Voice::Validators::CreateCall.new(params) }

    assert_match "Expected 'length_timer' parameter to be an Integer", exception.message 
  end

  def test_with_length_timer_too_small_value
    params = {
      to: [{type: 'phone', number: '14843331234'}],
      from: {type: 'phone', number: '14843335555'},
      ncco: [{action: 'talk', text: 'test text'}],
      length_timer: 0
    }

    exception = assert_raises { Vonage::Voice::Validators::CreateCall.new(params) }

    assert_match "Expected 'length_timer' parameter to be between 1 and 7200", exception.message 
  end

  def test_with_length_timer_too_large_value
    params = {
      to: [{type: 'phone', number: '14843331234'}],
      from: {type: 'phone', number: '14843335555'},
      ncco: [{action: 'talk', text: 'test text'}],
      length_timer: 7201
    }

    exception = assert_raises { Vonage::Voice::Validators::CreateCall.new(params) }

    assert_match "Expected 'length_timer' parameter to be between 1 and 7200", exception.message 
  end

  def test_with_machine_detection
    params = {
      to: [{type: 'phone', number: '14843331234'}],
      from: {type: 'phone', number: '14843335555'},
      ncco: [{action: 'talk', text: 'test text'}],
      machine_detection: 'continue'
    }

    builder = Vonage::Voice::Validators::CreateCall.new(params)

    assert_equal builder.machine_detection, params[:machine_detection]
    assert_kind_of String, builder.machine_detection
  end

  def test_with_machine_detection_wrong_object_type
    params = {
      to: [{type: 'phone', number: '14843331234'}],
      from: {type: 'phone', number: '14843335555'},
      ncco: [{action: 'talk', text: 'test text'}],
      machine_detection: ['hangup']
    }

    exception = assert_raises { Vonage::Voice::Validators::CreateCall.new(params) }

    assert_match "Expected value of 'machine_detection' parameter to be a String", exception.message 
  end

  def test_with_machine_detection_wrong_value
    params = {
      to: [{type: 'phone', number: '14843331234'}],
      from: {type: 'phone', number: '14843335555'},
      ncco: [{action: 'talk', text: 'test text'}],
      machine_detection: 'transfer'
    }

    exception = assert_raises { Vonage::Voice::Validators::CreateCall.new(params) }

    assert_match "Expected value of 'machine_detection' parameter to be either 'continue' or 'hangup'", exception.message 
  end
end