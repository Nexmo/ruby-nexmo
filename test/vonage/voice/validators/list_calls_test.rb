# typed: false

class Vonage::Voice::Validators::ListCallsTest < Vonage::Test
  def test_with_no_params
    builder = Vonage::Voice::Validators::ListCalls.new

    assert builder
  end

  def test_with_all_params
    params = {
      status: 'started',
      date_start: '2020-07-26',
      date_end: '2020-07-29',
      page_size: 10,
      record_index: 2,
      order: 'asc',
      conversation_uuid: 'CON-f972836a-550f-45fa-956c-12a2ab5b7d22'
    }

    builder = Vonage::Voice::Validators::ListCalls.new(params)

    assert_equal builder.status, params[:status]
    assert_equal builder.date_start, params[:date_start]
    assert_equal builder.date_end, params[:date_end]
    assert_equal builder.page_size, params[:page_size]
    assert_equal builder.record_index, params[:record_index]
    assert_equal builder.order, params[:order]
    assert_equal builder.conversation_uuid, params[:conversation_uuid]
  end

  def test_with_incorrect_status_param_type
    params = {
      status: 123
    }

    exception = assert_raises { Vonage::Voice::Validators::ListCalls.new(params) }

    assert_match "Expect 'status' parameter to be a String", exception.message
  end

  def test_with_incorrect_status_param_value
    params = {
      status: 'frozen'
    }

    exception = assert_raises { Vonage::Voice::Validators::ListCalls.new(params) }

    assert_match "Expect 'status' parameter to be one of: \"started\",\"ringing\",\"answered\",\"machine\",\"completed\",\"busy\",\"cancelled\",\"failed\",\"rejected\",\"timeout\",\"unanswered\"", exception.message
  end

  def test_with_incorrect_date_start_param_object_type
    params = {
      date_start: 123
    }

    exception = assert_raises { Vonage::Voice::Validators::ListCalls.new(params) }

    assert_match "Expect 'date_start' parameter to be a String", exception.message
  end

  def test_with_incorrect_date_start_param_date_format
    params = {
      date_start: 'May 12 2020 08:35am'
    }

    exception = assert_raises { Vonage::Voice::Validators::ListCalls.new(params) }

    assert_match "Expect 'date_start' parameter to be in ISO8601 format", exception.message
  end

  def test_with_incorrect_date_end_param_object_type
    params = {
      date_end: 123
    }

    exception = assert_raises { Vonage::Voice::Validators::ListCalls.new(params) }

    assert_match "Expect 'date_end' parameter to be a String", exception.message
  end

  def test_with_incorrect_date_end_param_date_format
    params = {
      date_end: 'May 12 2020 08:35am'
    }

    exception = assert_raises { Vonage::Voice::Validators::ListCalls.new(params) }

    assert_match "Expect 'date_end' parameter to be in ISO8601 format", exception.message
  end

  def test_with_incorrect_page_size_type
    params = {
      page_size: '12'
    }

    exception = assert_raises { Vonage::Voice::Validators::ListCalls.new(params) }

    assert_match "Expect 'page_size' parameter to be an Integer", exception.message
  end

  def test_with_incorrect_record_index_type
    params = {
      record_index: '12'
    }

    exception = assert_raises { Vonage::Voice::Validators::ListCalls.new(params) }

    assert_match "Expect 'record_index' parameter to be an Integer", exception.message
  end

  def test_with_incorrect_order_param_type
    params = {
      order: 123
    }

    exception = assert_raises { Vonage::Voice::Validators::ListCalls.new(params) }

    assert_match "Expect 'order' parameter to be a String", exception.message
  end

  def test_with_incorrect_order_param_value
    params= {
      order: 'upwards'
    }

    exception = assert_raises { Vonage::Voice::Validators::ListCalls.new(params) }

    assert_match "Expect 'order' parameter value to be either 'asc' or 'desc'", exception.message
  end

  def test_with_incorrect_conversation_uuid_param_type
    params = {
      conversation_uuid: 123
    }

    exception = assert_raises { Vonage::Voice::Validators::ListCalls.new(params) }

    assert_match "Expect 'conversation_uuid' parameter to be a String", exception.message
  end
end