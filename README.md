kona-ruby-logger gem

Description
------------
This gem implements a simple logger.

h4. params:
   * logfile - log file or STDOUT. default: STDOUT
   * loglevel - debug, info, error, fatal, warn. default: info

logger can be disabled thru accessor called 'disabled'

Example
----------
`logger = KonaLogger::Logger.new(STDOUT, 'debug')`

`logger.debug(msg)`
