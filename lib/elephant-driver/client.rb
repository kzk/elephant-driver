module ElephantDriver

  class Client
    def initialize(host, port=9290, user='mapred', timeout=30)
      sock = Thrift::Socket.new host, port
      sock.timeout = timeout * 1000

      @transport = Thrift::BufferedTransport.new sock
      @transport.open

      # 2011/08/23 Kazuki Ohta <kazuki.ohta@gmail.com>
      # explicitly specify TCP_NODELAY for low-latency communication.
      raw_sock = sock.to_io
      raw_sock.setsockopt Socket::IPPROTO_TCP, Socket::TCP_NODELAY, 1

      protocol = Thrift::BinaryProtocol.new @transport
      @client = Hadoop::API::Jobtracker::Jobtracker::Client.new protocol
      options = { 'effective_user' => user }
      @ctx = Hadoop::API::RequestContext.new(:confOptions => options)
    end

    # Jobs
    def jobs(status=:running)
      ret =
        case status
        when :running   then call :getRunningJobs
        when :completed then call :getCompletedJobs
        when :failed    then call :getFailedJobs
        when :killed    then call :getKilledJobs
        else call :getAllJobs
        end
      ret.jobs.collect{ |j| Job.new(self, j) }
    end

    def get_job(job_id)
      Job.new self, call(:getJob, job_id)
    end

    # Trackers
    def trackers(status=:active)
      ret =
        case status
        when :active then call :getActiveTrackers
        when :blacklisted then call :getBlacklistedTrackers
        else call :getAllTrackers
        end
      ret.trackers.collect{ |t| Tracker.new(self, t) }
    end

    def get_tracker(name)
      Tracker.new(self, (call :getTracker, name))
    end

    # Tasks
    def tasks
    end

    # Status
    def status
      call :getClusterStatus
    end

    private
    def call(method, *args)
      @client.send method, @ctx, *args
    end
  end

end
