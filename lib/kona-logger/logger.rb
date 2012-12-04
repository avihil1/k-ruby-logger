require 'colorize'
require 'logger'

module KonaLogger

  class Logger

    attr_accessor :logger, :disabled

    @@severties = Hash.new{::Logger::INFO}.merge!({'debug' => ::Logger::DEBUG, "info" => ::Logger::INFO, "warn" => ::Logger::WARN, "error" => ::Logger::ERROR, "fatal" => ::Logger::FATAL})

    def initialize(logfile, severity)
			self.logger = ::Logger.new(logfile.nil? ? STDOUT : logfile)
      self.logger.level =  severity.nil? ? @@severties['info'] : @@severties[severity]
      self.logger.formatter = proc { |s, dt, pr, msg|
        def get_callee(msg, caller)
          msg.is_a?(String) ? "#{caller[0].gsub(/:in.*/,'').split('/')[-1]}" : msg[:callee]
        end

        def get_msg(msg)
          msg.is_a?(String) ? msg : msg[:msg]
        end

        "[#{dt.strftime("%Y-%m-%dT%T").magenta}][#{color_severity(s)}][#{get_callee(msg, caller)}] #{get_msg(msg)}"
      }
    end

    def level= l
      logger.level=l if logger.respond_to? :level
    end

    def progress message
      logger.info(message) if logger.respond_to? :info
    end

    def fatal msg
      logger.fatal([msg,"\n"].join) if logger.respond_to? :fatal
      exit 1
    end

    def method_missing(m,*args,&block)
      msg = {:msg => "#{args.first.to_s}\n", :callee => caller[0].gsub(/:in.*/,'').split('/')[-1] }
      logger.send(m, msg) if logger.respond_to?(m) && !disabled
    end

    def self.method_missing(m,*args,&block)
      instance.send(m,*args,&block)
    end

    private

    def color_severity(s)
      case s
        when 'INFO' then s.blue
        when 'DEBUG' then s.green
        when 'FATAL' then s.red
        when 'ERROR'; s.light_red
        when 'WARN'; s.yellow
        else s.blue
      end
    end

  end
  
end


