require 'nokogiri'

module ElephantDriver

  class Job
    STATES = [ :running, :succeeded, :failed, :prep, :killed ]

    def initialize(cln, thrift_job)
      @cln = cln
      @thrift_job = thrift_job
    end

    def job_id
      @thrift_job.jobID
    end

    def user
      @thrift_job.status.user
    end

    def completed?
      state != :running
    end

    def start_time
      @thrift_job.startTime
    end

    def launch_time
      @thrift_job.launchTime
    end

    def finish_time
      @thrift_job.finishTime
    end

    def state
      STATES[@thrift_job.status.runState - 1]
    end

    def map_progress
      @thrift_job.status.mapProgress
    end

    def reduce_progress
      @thrift_job.status.reduceProgress
    end

    def cleanup_progress
      @thrift_job.status.cleanupProgress
    end

    def setup_progress
      @thrift_job.status.setupProgress
    end

    def progress
      (@thrift_job.status.mapProgress + @thrift_job.status.reduceProgress) / 2.0
    end

    def config_params
      xml = call :getJobConfXML
      #@parsed_config ||= Nokogiri::XML(xml).xpath("//property").inject({}) { |props, xprop|
      #  props[xprop.xpath("./name").text] = xprop.xpath("./value").text
      #  props
      #}
      {}
    end

    def counters
      counters = {}
      ret = call :getJobCounters
      ret.groups.each { |g|
        h = {}
        g.counters.each { |name, c| h[name] = c.value }
        counters[g.name] = h
      }
      counters
    end

    def tasks
      types = [
        Hadoop::API::Jobtracker::ThriftTaskType::MAP,
        Hadoop::API::Jobtracker::ThriftTaskType::REDUCE,
        Hadoop::API::Jobtracker::ThriftTaskType::JOB_SETUP,
        Hadoop::API::Jobtracker::ThriftTaskType::JOB_CLEANUP,
        Hadoop::API::Jobtracker::ThriftTaskType::TASK_CLEANUP,
      ]
      states = [
        Hadoop::API::Jobtracker::ThriftTaskState::RUNNING,
        Hadoop::API::Jobtracker::ThriftTaskState::SUCCEEDED,
        Hadoop::API::Jobtracker::ThriftTaskState::FAILED,
        Hadoop::API::Jobtracker::ThriftTaskState::UNASSIGNED,
        Hadoop::API::Jobtracker::ThriftTaskState::KILLED,
        Hadoop::API::Jobtracker::ThriftTaskState::COMMIT_PENDING,
        Hadoop::API::Jobtracker::ThriftTaskState::FAILED_UNCLEAN,
        Hadoop::API::Jobtracker::ThriftTaskState::KILLED_UNCLEAN,
      ]

      tasks = (call :getTaskList, types, states, '', 10000, 0).tasks
      return tasks.collect{ |t| Task.new(self, t) }
    end

    def set_priority(priority)
      prio =
        case priority
        when :very_high then Hadoop::API::Jobtracker::ThriftJobPriority::VERY_HIGH
        when :high      then Hadoop::API::Jobtracker::ThriftJobPriority::HIGH
        when :normal    then Hadoop::API::Jobtracker::ThriftJobPriority::NORMAL
        when :low       then Hadoop::API::Jobtracker::ThriftJobPriority::LOW
        when :very_low  then Hadoop::API::Jobtracker::ThriftJobPriority::VERY_LOW
        else Hadoop::API::Jobtracker::ThriftJobPriority::NORMAL
        end
      call :setJobPriority, prio
    end

    def kill!
      call :killJob
    end

    private
    def call(method, *args)
      @cln.send :call, method, @thrift_job.jobID, *args
    end
  end

end
