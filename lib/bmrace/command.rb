module Bmrace
  class Command
    class << self
      def ready(*arguments)
        new(arguments)
      end
    end

    def initialize(commands)
      @commands = commands
    end

    def go!
      threads = {}
      results = {}

      @commands.each do |cmd|
        threads[cmd] = Thread.new do
          start_time = Time.now
          `#{cmd}`
          end_time = Time.now
          results[cmd] = end_time - start_time
        end
      end

      threads.each do |cmd, thread|
        thread.join
      end

      results.each do |cmd, time|
        puts "#{cmd}: #{time}"
      end
    end
  end
end
