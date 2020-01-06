function poll
    function __print_help
        printf "Usage:\n"
        printf "    poll [-e] [-n COUNTS] [-s SECONDS] IN OUT\n\n"
        printf "Example:\n"
        printf "    poll -s 60 'cat /path/to/watch' 'beep -f 100 -l 500'\n\n"
        printf "Args:\n"
        printf "    <IN>                     Command to be run for polling\n"
        printf "    <OUT>                    Command to be run when the output of the polling was changed\n\n"
        printf "Options:\n"
        printf "    -e, --exit               Quit when the output of the polling was changed\n"
        printf "    -n, --num <COUNTS>       Max number of attempts for polling\n"
        printf "    -s, --sleep <SECONDS>    Interval between polling\n"
        printf "    -h, --help               Print this help\n"
    end

    argparse 'e/exit' 's/sleep=' 'n/num=' 'h/help' -- $argv    
    
    if not set -q argv[2]
        __print_help
        return 1
    end

    if set -q _flag_help
        __print_help
        return 0
    end

    set -l sleep_seconds 0
    if set -q _flag_sleep
        set sleep_seconds $_flag_sleep
    end

    set -l max_counter 0
    if set -q _flag_num
        set max_counter $_flag_num
    end

    set -l quit_after_trigger false
    if set -q _flag_exit
        set quit_after_trigger true
    end

    set -l poll_cmd $argv[1]
    set -l triggered_cmd $argv[2]
    set -l counter 0
    while true
        set last_stdout (eval $poll_cmd)
        if set -q prev_stdout
            if [ (echo $prev_stdout) != (echo $last_stdout) ]
                eval $triggered_cmd
                if $quit_after_trigger
                    return 0
                end
            end
            set counter (math $counter + 1)
        end
        set prev_stdout $last_stdout
        if [ $max_counter -gt 0 ] && [ $counter -ge $max_counter ]
            break
        end
        sleep $sleep_seconds
    end
end