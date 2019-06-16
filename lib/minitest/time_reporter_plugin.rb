module Minitest
  def self.plugin_time_reporter_options(opts, options)
    opts.on "--time", "Report tests sorted by runtime" do
      options[:report_time] = true
    end
  end

  def self.plugin_time_reporter_init(options)
    self.reporter << TimeReporter.new if options[:report_time]
  end

  class TimeReporter < AbstractReporter

    def initialize
      @results = []
    end

    def record(result)
      @skip_reporter ||= !result.passed?
      @results << result unless result.skipped? || !result.passed?
    end

    def report
      puts
      puts

      if @skip_reporter
        puts 'Skipping TimeReporter because there was a failure.'
      else
        @results.sort_by(&:time).each do |result|
          puts [
            "%.2f s" % [result.time],
            "%s#%s" % [result.klass, result.name],
          ].join(' = ')
        end
      end
    end

  end
end
