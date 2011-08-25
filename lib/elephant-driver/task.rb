require 'nokogiri'

module ElephantDriver

  class Task
    def initialize(cln, thrift_task)
      @cln = cln
      @thrift_task = thrift_task
    end

    def start_time
      @thrift_task.startTime
    end

    def exec_start_time
      @thrift_task.execStartTime
    end

    def exec_finish_time
      @thrift_task.execFinishTime
    end

    def progress
      @thrift_task.progress
    end

    def failed?
      @thrift_task.failed
    end

    def completed?
      @thrift_task.complete
    end

    def counters
      counters = {}
      @thrift_task.counters.groups.each { |g|
        h = {}
        g.counters.each { |name, c| h[name] = c.value }
        counters[g.name] = h
      }
      counters
    end
  end

end
