class ThrowException < StandardError

  def initialize(msg = "An exception occurred")
    super(msg)
  end
  
end