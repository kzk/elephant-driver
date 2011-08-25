module ElephantDriver

  class Tracker
    def initialize(cln, thrift_tracker)
      @cln = cln
      @thrift_tracker = thrift_tracker
    end
  end

end
