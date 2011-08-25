require 'base.rb'

describe ElephantDriver::Client do
  before do
    @cln = ElephantDriver::Client.new($HOST, $PORT)
  end
  
  it "should return jobs" do
    @cln.jobs.is_a?(Array).should == true
    @cln.jobs(:running).is_a?(Array).should == true
    @cln.jobs(:completed).is_a?(Array).should == true
    @cln.jobs(:failed).is_a?(Array).should == true
    @cln.jobs(:killed).is_a?(Array).should == true
  end

  it "should return jobs with correct information" do
    @cln.jobs(:all).each_with_index { |j, i|
      j.job_id
      j.user
      j.completed?
      j.start_time
      j.launch_time
      j.finish_time
      j.state
      j.map_progress
      j.reduce_progress
      j.cleanup_progress
      j.progress
      j.config_params
      j.counters
      @cln.get_job(j.job_id)
      break
    }
  end

  it "should return jobs with tasks information" do
    @cln.jobs(:all).each { |j|
      ts = j.tasks
      ts.length.should_not == 0
      ts.each { |t|
        t.start_time
        t.exec_start_time
        t.exec_finish_time
        t.progress
        t.failed?
        t.completed?
        t.counters
        break
      }
      break
    }
  end

  it "should correctly set the priority" do
    @cln.jobs(:all).each { |j|
      j.set_priority :very_high
      break
    }
  end
end
