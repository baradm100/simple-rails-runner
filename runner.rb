TIMEOUT = 2.0.freeze
PID_PATH = './tmp/pids/runner.pid'.freeze


# Parse custom_timeout argument flag
# @return [nilClass|Integer] what the custom timeout is
def parse_custom_timeout
    if ARGV.include?('--timeout')
        custom_timeout = ARGV[ARGV.index('--timeout') + 1]

        if custom_timeout && custom_timeout.to_f > 0
            custom_timeout.to_f
        else
            nil
        end
    end
end

# Parse custom_eval argument flag
# @return [nilClass|String] what the custom eval is
def parse_custom_eval
    if ARGV.include?('--eval')
        ARGV[ARGV.index('--eval') + 1]
    end
end

# @params [Object] value the thing to print
def appand_to_log(value)
    log_path = ARGV[ARGV.index('--log') + 1]

    # creating the full path of the log folder
    full_path = log_path.split('/').reverse.drop(1).reverse.join('/')
    FileUtils.mkdir_p(full_path)

    # appand the value to the value
    open(log_path, 'a') do |f|
        f.puts value
    end
end

# @params [Object] value the thing to print
def print(value)
    if ARGV.include? '--log'
        appand_to_log value
    else
        super value
    end
end

# @params [Object] value the thing to print
# @return [Object] returns the +value+
def p(value)
    if ARGV.include? '--log'
        appand_to_log value
    else
        super value
    end

    value
end

# @params [Object] value the thing to print
def puts(value)
    if ARGV.include? '--log'
        appand_to_log value
    else
        super value
    end
end

# Initializing
puts 'Starting the runner...'

# if there is a runner that already running then exiting
if File.exist?(PID_PATH)
    puts 'There is a runner already running!'
    puts "Check for pid in: #{PID_PATH}"
    exit
end

# creating the full path of the pid folder
full_path = PID_PATH.split('/').reverse.drop(1).reverse.join('/')
FileUtils.mkdir_p(full_path)

# writing the runner pid to file
open(PID_PATH, 'w') { |f| f.puts Process.pid }

# adds +at_exit+, removing PID file if exists
at_exit do
    File.delete(PID_PATH) if File.exist?(PID_PATH)
end

# parsing args
custom_timeout = parse_custom_timeout()
custom_eval = parse_custom_eval()

# make daemon if needed to
Process.daemon if ARGV.include? '-D'


# Infinte loop
loop do
    if custom_eval
        eval custom_eval
    else
        puts 'Good morinning!'
    end

    sleep(custom_timeout || TIMEOUT)
end
