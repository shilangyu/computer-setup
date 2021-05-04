complete -c dart -s h -l help               -d 'Print this usage information.'
complete -c dart -s v -l verbose            -d 'Show additional command output.'
complete -c dart      -l version            -d 'Print  the Dart SDK version.'
complete -c dart      -l enable-analytics   -d 'Enable anonymous analytics.'
complete -c dart      -l disable-analytics  -d 'Disable anonymous analytics.'

complete -c dart -n "__fish_use_subcommand" -a analyze                         -d 'Analyze the project\'s Dart code.'
complete -c dart -n "__fish_seen_subcommand_from analyze" -l fatal-infos       -d 'Treat info level issues as fatal.'
complete -c dart -n "__fish_seen_subcommand_from analyze" -l fatal-warnings    -d 'Treat warning level issues as fatal. (defaults to on)'
complete -c dart -n "__fish_seen_subcommand_from analyze" -l no-fatal-warnings -d 'Treat warning level issues as fatal. (defaults to on)'



complete -c dart -n "__fish_use_subcommand"            -f -a compile      -d 'Compile Dart to various formats.'
complete -c dart -n "__fish_seen_subcommand_from compile" -a aot-snapshot -d 'Compile Dart to an AOT snapshot.'
complete -c dart -n "__fish_seen_subcommand_from compile" -a exe          -d 'Compile Dart to a self-contained executable.'
complete -c dart -n "__fish_seen_subcommand_from compile" -a jit-snapshot -d 'Compile Dart to a JIT snapshot.'
complete -c dart -n "__fish_seen_subcommand_from compile" -a js           -d 'Compile Dart to JavaScript.'
complete -c dart -n "__fish_seen_subcommand_from compile" -a kernel       -d 'Compile Dart to a kernel snapshot.'


complete -c dart -n "__fish_use_subcommand" -a create    -d 'Create a new project.'
complete -c dart -n "__fish_use_subcommand" -a fix       -d 'Apply automated fixes to Dart source code.'
complete -c dart -n "__fish_use_subcommand" -a format    -d 'Idiomatically format Dart source code.'
complete -c dart -n "__fish_use_subcommand" -a migrate   -d 'Perform a null safety migration on a project or package.'
complete -c dart -n "__fish_use_subcommand" -a pub       -d 'Work with packages.'
complete -c dart -n "__fish_use_subcommand" -a run       -d 'Run a Dart program.'
complete -c dart -n "__fish_use_subcommand" -a test      -d 'Run tests in this package.'