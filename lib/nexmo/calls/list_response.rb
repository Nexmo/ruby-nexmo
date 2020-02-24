# typed: ignore

class Nexmo::Calls::ListResponse < Nexmo::Response
  include Enumerable

  def each
    return enum_for(:each) unless block_given?

    @entity._embedded.calls.each { |item| yield item }
  end
end
