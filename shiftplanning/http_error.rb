class ShiftPlanning
  class HTTPError < Exception
    def initialize code
      super
      message = code.to_s
    end
  end
end
