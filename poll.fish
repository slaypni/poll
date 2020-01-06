function poll
    function __print_help
        printf "Usage:\n"
        printf "    poll [-s SECONDS] IN OUT\n\n"
        printf "Example:\n"
        printf "    poll -s 60 'cat /path/to/watch' 'beep -f 100 -l 500'\n\n"
        printf "Args:\n"
        printf "    IN            Command to be run for polling\n"
        printf "    OUT           Command to be run when output of the last polling was changed\n\n"
        printf "Options:\n"
        printf "    -s --sleep    Interval between polling\n"
        printf "    -h --help     Print this help\n"
    end

    set -l sleep_seconds 0
    argparse 's/sleep=' 'h/help' -- $argv
    if set -q _flag_help
        __print_help
        return 0
    end
    if set -q _flag_sleep
        set sleep_seconds $_flag_sleep
    end
    if not set -q argv[2]
        __print_help
        return 1
    end
    set -l poll_cmd $argv[1]
    set -l triggered_cmd $argv[2]

    while true
        set last_stdout (eval $poll_cmd)
        if set -q prev_stdout
            if [ (echo $prev_stdout) != (echo $last_stdout) ]
                eval $triggered_cmd
            end
        end
        set prev_stdout $last_stdout
        sleep $sleep_seconds
    end
end