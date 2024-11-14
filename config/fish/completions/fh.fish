# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_fh_global_optspecs
	string join \n api-addr= cache-addr= frontend-addr= v/verbose logger= log-directive= h/help V/version
end

function __fish_fh_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_fh_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_fh_using_subcommand
	set -l cmd (__fish_fh_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c fh -n "__fish_fh_needs_command" -l api-addr -d 'The FlakeHub address to communicate with' -r
complete -c fh -n "__fish_fh_needs_command" -l cache-addr -d 'The FlakeHub cache to communicate with' -r
complete -c fh -n "__fish_fh_needs_command" -l frontend-addr -d 'The FlakeHub frontend address to communicate with' -r
complete -c fh -n "__fish_fh_needs_command" -l logger -d 'Which logger to use' -r -f -a "{compact\t'',full\t'',pretty\t'',json\t''}"
complete -c fh -n "__fish_fh_needs_command" -l log-directive -d 'Tracing directives' -r
complete -c fh -n "__fish_fh_needs_command" -s v -l verbose -d 'Enable debug logs, -vv for trace'
complete -c fh -n "__fish_fh_needs_command" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fh -n "__fish_fh_needs_command" -s V -l version -d 'Print version'
complete -c fh -n "__fish_fh_needs_command" -f -a "add" -d 'Adds a flake input to your flake.nix'
complete -c fh -n "__fish_fh_needs_command" -f -a "apply" -d 'Apply the configuration at the specified FlakeHub output reference to the current system'
complete -c fh -n "__fish_fh_needs_command" -f -a "completion" -d 'Prints completion for shells to use'
complete -c fh -n "__fish_fh_needs_command" -f -a "convert" -d 'Convert flake inputs to FlakeHub when possible'
complete -c fh -n "__fish_fh_needs_command" -f -a "eject" -d 'Convert flake inputs from FlakeHub back to GitHub'
complete -c fh -n "__fish_fh_needs_command" -f -a "init" -d 'Create a new flake.nix using an opinionated interactive initializer'
complete -c fh -n "__fish_fh_needs_command" -f -a "list" -d 'Lists key FlakeHub resources'
complete -c fh -n "__fish_fh_needs_command" -f -a "login" -d 'Log in to FlakeHub in order to allow authenticated fetching of flakes'
complete -c fh -n "__fish_fh_needs_command" -f -a "resolve" -d 'Resolves a FlakeHub flake reference into a store path'
complete -c fh -n "__fish_fh_needs_command" -f -a "search" -d 'Searches FlakeHub for flakes that match your query'
complete -c fh -n "__fish_fh_needs_command" -f -a "status" -d 'Check your FlakeHub token status'
complete -c fh -n "__fish_fh_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fh -n "__fish_fh_using_subcommand add" -l flake-path -d 'The flake.nix to modify' -r -F
complete -c fh -n "__fish_fh_using_subcommand add" -l input-name -d 'The name of the flake input' -r
complete -c fh -n "__fish_fh_using_subcommand add" -l insertion-location -d 'Whether to insert a new input at the top of or the bottom of an existing `inputs` attrset' -r
complete -c fh -n "__fish_fh_using_subcommand add" -l api-addr -d 'The FlakeHub address to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand add" -l cache-addr -d 'The FlakeHub cache to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand add" -l frontend-addr -d 'The FlakeHub frontend address to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand add" -l logger -d 'Which logger to use' -r -f -a "{compact\t'',full\t'',pretty\t'',json\t''}"
complete -c fh -n "__fish_fh_using_subcommand add" -l log-directive -d 'Tracing directives' -r
complete -c fh -n "__fish_fh_using_subcommand add" -l dry-run -d 'Print to stdout the new flake.nix contents instead of writing it to disk'
complete -c fh -n "__fish_fh_using_subcommand add" -s v -l verbose -d 'Enable debug logs, -vv for trace'
complete -c fh -n "__fish_fh_using_subcommand add" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fh -n "__fish_fh_using_subcommand apply; and not __fish_seen_subcommand_from home-manager nix-darwin nixos help" -l api-addr -d 'The FlakeHub address to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand apply; and not __fish_seen_subcommand_from home-manager nix-darwin nixos help" -l cache-addr -d 'The FlakeHub cache to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand apply; and not __fish_seen_subcommand_from home-manager nix-darwin nixos help" -l frontend-addr -d 'The FlakeHub frontend address to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand apply; and not __fish_seen_subcommand_from home-manager nix-darwin nixos help" -l logger -d 'Which logger to use' -r -f -a "{compact\t'',full\t'',pretty\t'',json\t''}"
complete -c fh -n "__fish_fh_using_subcommand apply; and not __fish_seen_subcommand_from home-manager nix-darwin nixos help" -l log-directive -d 'Tracing directives' -r
complete -c fh -n "__fish_fh_using_subcommand apply; and not __fish_seen_subcommand_from home-manager nix-darwin nixos help" -l use-scoped-token -d 'Use a scoped token generated by FlakeHub that allows substituting the given output _only_'
complete -c fh -n "__fish_fh_using_subcommand apply; and not __fish_seen_subcommand_from home-manager nix-darwin nixos help" -s v -l verbose -d 'Enable debug logs, -vv for trace'
complete -c fh -n "__fish_fh_using_subcommand apply; and not __fish_seen_subcommand_from home-manager nix-darwin nixos help" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fh -n "__fish_fh_using_subcommand apply; and not __fish_seen_subcommand_from home-manager nix-darwin nixos help" -f -a "home-manager" -d 'Resolve the store path for a Home Manager configuration and run its activation script'
complete -c fh -n "__fish_fh_using_subcommand apply; and not __fish_seen_subcommand_from home-manager nix-darwin nixos help" -f -a "nix-darwin" -d 'Resolve the store path for a nix-darwin configuration and run its activation script'
complete -c fh -n "__fish_fh_using_subcommand apply; and not __fish_seen_subcommand_from home-manager nix-darwin nixos help" -f -a "nixos" -d 'Apply the resolved store path on a NixOS system'
complete -c fh -n "__fish_fh_using_subcommand apply; and not __fish_seen_subcommand_from home-manager nix-darwin nixos help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fh -n "__fish_fh_using_subcommand apply; and __fish_seen_subcommand_from home-manager" -l api-addr -d 'The FlakeHub address to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand apply; and __fish_seen_subcommand_from home-manager" -l cache-addr -d 'The FlakeHub cache to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand apply; and __fish_seen_subcommand_from home-manager" -l frontend-addr -d 'The FlakeHub frontend address to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand apply; and __fish_seen_subcommand_from home-manager" -l logger -d 'Which logger to use' -r -f -a "{compact\t'',full\t'',pretty\t'',json\t''}"
complete -c fh -n "__fish_fh_using_subcommand apply; and __fish_seen_subcommand_from home-manager" -l log-directive -d 'Tracing directives' -r
complete -c fh -n "__fish_fh_using_subcommand apply; and __fish_seen_subcommand_from home-manager" -s v -l verbose -d 'Enable debug logs, -vv for trace'
complete -c fh -n "__fish_fh_using_subcommand apply; and __fish_seen_subcommand_from home-manager" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fh -n "__fish_fh_using_subcommand apply; and __fish_seen_subcommand_from nix-darwin" -s p -l profile -r -F
complete -c fh -n "__fish_fh_using_subcommand apply; and __fish_seen_subcommand_from nix-darwin" -l api-addr -d 'The FlakeHub address to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand apply; and __fish_seen_subcommand_from nix-darwin" -l cache-addr -d 'The FlakeHub cache to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand apply; and __fish_seen_subcommand_from nix-darwin" -l frontend-addr -d 'The FlakeHub frontend address to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand apply; and __fish_seen_subcommand_from nix-darwin" -l logger -d 'Which logger to use' -r -f -a "{compact\t'',full\t'',pretty\t'',json\t''}"
complete -c fh -n "__fish_fh_using_subcommand apply; and __fish_seen_subcommand_from nix-darwin" -l log-directive -d 'Tracing directives' -r
complete -c fh -n "__fish_fh_using_subcommand apply; and __fish_seen_subcommand_from nix-darwin" -s v -l verbose -d 'Enable debug logs, -vv for trace'
complete -c fh -n "__fish_fh_using_subcommand apply; and __fish_seen_subcommand_from nix-darwin" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fh -n "__fish_fh_using_subcommand apply; and __fish_seen_subcommand_from nixos" -l api-addr -d 'The FlakeHub address to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand apply; and __fish_seen_subcommand_from nixos" -l cache-addr -d 'The FlakeHub cache to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand apply; and __fish_seen_subcommand_from nixos" -l frontend-addr -d 'The FlakeHub frontend address to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand apply; and __fish_seen_subcommand_from nixos" -l logger -d 'Which logger to use' -r -f -a "{compact\t'',full\t'',pretty\t'',json\t''}"
complete -c fh -n "__fish_fh_using_subcommand apply; and __fish_seen_subcommand_from nixos" -l log-directive -d 'Tracing directives' -r
complete -c fh -n "__fish_fh_using_subcommand apply; and __fish_seen_subcommand_from nixos" -s v -l verbose -d 'Enable debug logs, -vv for trace'
complete -c fh -n "__fish_fh_using_subcommand apply; and __fish_seen_subcommand_from nixos" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fh -n "__fish_fh_using_subcommand apply; and __fish_seen_subcommand_from help" -f -a "home-manager" -d 'Resolve the store path for a Home Manager configuration and run its activation script'
complete -c fh -n "__fish_fh_using_subcommand apply; and __fish_seen_subcommand_from help" -f -a "nix-darwin" -d 'Resolve the store path for a nix-darwin configuration and run its activation script'
complete -c fh -n "__fish_fh_using_subcommand apply; and __fish_seen_subcommand_from help" -f -a "nixos" -d 'Apply the resolved store path on a NixOS system'
complete -c fh -n "__fish_fh_using_subcommand apply; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fh -n "__fish_fh_using_subcommand completion" -l api-addr -d 'The FlakeHub address to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand completion" -l cache-addr -d 'The FlakeHub cache to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand completion" -l frontend-addr -d 'The FlakeHub frontend address to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand completion" -l logger -d 'Which logger to use' -r -f -a "{compact\t'',full\t'',pretty\t'',json\t''}"
complete -c fh -n "__fish_fh_using_subcommand completion" -l log-directive -d 'Tracing directives' -r
complete -c fh -n "__fish_fh_using_subcommand completion" -s v -l verbose -d 'Enable debug logs, -vv for trace'
complete -c fh -n "__fish_fh_using_subcommand completion" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fh -n "__fish_fh_using_subcommand convert" -l flake-path -d 'The flake.nix to convert' -r -F
complete -c fh -n "__fish_fh_using_subcommand convert" -l api-addr -d 'The FlakeHub address to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand convert" -l cache-addr -d 'The FlakeHub cache to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand convert" -l frontend-addr -d 'The FlakeHub frontend address to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand convert" -l logger -d 'Which logger to use' -r -f -a "{compact\t'',full\t'',pretty\t'',json\t''}"
complete -c fh -n "__fish_fh_using_subcommand convert" -l log-directive -d 'Tracing directives' -r
complete -c fh -n "__fish_fh_using_subcommand convert" -l dry-run -d 'Print to stdout the new flake.nix contents instead of writing it to disk'
complete -c fh -n "__fish_fh_using_subcommand convert" -s v -l verbose -d 'Enable debug logs, -vv for trace'
complete -c fh -n "__fish_fh_using_subcommand convert" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fh -n "__fish_fh_using_subcommand eject" -l flake-path -d 'The flake.nix to convert' -r -F
complete -c fh -n "__fish_fh_using_subcommand eject" -l api-addr -d 'The FlakeHub address to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand eject" -l cache-addr -d 'The FlakeHub cache to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand eject" -l frontend-addr -d 'The FlakeHub frontend address to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand eject" -l logger -d 'Which logger to use' -r -f -a "{compact\t'',full\t'',pretty\t'',json\t''}"
complete -c fh -n "__fish_fh_using_subcommand eject" -l log-directive -d 'Tracing directives' -r
complete -c fh -n "__fish_fh_using_subcommand eject" -l dry-run -d 'Print to stdout the new flake.nix contents instead of writing it to disk'
complete -c fh -n "__fish_fh_using_subcommand eject" -s v -l verbose -d 'Enable debug logs, -vv for trace'
complete -c fh -n "__fish_fh_using_subcommand eject" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fh -n "__fish_fh_using_subcommand init" -s r -l root -r -F
complete -c fh -n "__fish_fh_using_subcommand init" -s o -l output -r -F
complete -c fh -n "__fish_fh_using_subcommand init" -l api-addr -d 'The FlakeHub address to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand init" -l cache-addr -d 'The FlakeHub cache to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand init" -l frontend-addr -d 'The FlakeHub frontend address to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand init" -l logger -d 'Which logger to use' -r -f -a "{compact\t'',full\t'',pretty\t'',json\t''}"
complete -c fh -n "__fish_fh_using_subcommand init" -l log-directive -d 'Tracing directives' -r
complete -c fh -n "__fish_fh_using_subcommand init" -s v -l verbose -d 'Enable debug logs, -vv for trace'
complete -c fh -n "__fish_fh_using_subcommand init" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fh -n "__fish_fh_using_subcommand list; and not __fish_seen_subcommand_from flakes label orgs releases versions help" -l api-addr -d 'The FlakeHub address to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand list; and not __fish_seen_subcommand_from flakes label orgs releases versions help" -l cache-addr -d 'The FlakeHub cache to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand list; and not __fish_seen_subcommand_from flakes label orgs releases versions help" -l frontend-addr -d 'The FlakeHub frontend address to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand list; and not __fish_seen_subcommand_from flakes label orgs releases versions help" -l logger -d 'Which logger to use' -r -f -a "{compact\t'',full\t'',pretty\t'',json\t''}"
complete -c fh -n "__fish_fh_using_subcommand list; and not __fish_seen_subcommand_from flakes label orgs releases versions help" -l log-directive -d 'Tracing directives' -r
complete -c fh -n "__fish_fh_using_subcommand list; and not __fish_seen_subcommand_from flakes label orgs releases versions help" -l json -d 'Output results as JSON'
complete -c fh -n "__fish_fh_using_subcommand list; and not __fish_seen_subcommand_from flakes label orgs releases versions help" -s v -l verbose -d 'Enable debug logs, -vv for trace'
complete -c fh -n "__fish_fh_using_subcommand list; and not __fish_seen_subcommand_from flakes label orgs releases versions help" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fh -n "__fish_fh_using_subcommand list; and not __fish_seen_subcommand_from flakes label orgs releases versions help" -f -a "flakes" -d 'Lists all currently public flakes on FlakeHub'
complete -c fh -n "__fish_fh_using_subcommand list; and not __fish_seen_subcommand_from flakes label orgs releases versions help" -f -a "label" -d 'Lists all public flakes with the provided label'
complete -c fh -n "__fish_fh_using_subcommand list; and not __fish_seen_subcommand_from flakes label orgs releases versions help" -f -a "orgs" -d 'Lists all currently public organizations on FlakeHub'
complete -c fh -n "__fish_fh_using_subcommand list; and not __fish_seen_subcommand_from flakes label orgs releases versions help" -f -a "releases" -d 'List all releases for a specific flake on FlakeHub'
complete -c fh -n "__fish_fh_using_subcommand list; and not __fish_seen_subcommand_from flakes label orgs releases versions help" -f -a "versions" -d 'List all versions that match the provided version constraint'
complete -c fh -n "__fish_fh_using_subcommand list; and not __fish_seen_subcommand_from flakes label orgs releases versions help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from flakes" -l api-addr -d 'The FlakeHub address to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from flakes" -l cache-addr -d 'The FlakeHub cache to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from flakes" -l frontend-addr -d 'The FlakeHub frontend address to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from flakes" -l logger -d 'Which logger to use' -r -f -a "{compact\t'',full\t'',pretty\t'',json\t''}"
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from flakes" -l log-directive -d 'Tracing directives' -r
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from flakes" -l json -d 'Output results as JSON'
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from flakes" -s v -l verbose -d 'Enable debug logs, -vv for trace'
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from flakes" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from label" -l api-addr -d 'The FlakeHub address to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from label" -l cache-addr -d 'The FlakeHub cache to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from label" -l frontend-addr -d 'The FlakeHub frontend address to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from label" -l logger -d 'Which logger to use' -r -f -a "{compact\t'',full\t'',pretty\t'',json\t''}"
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from label" -l log-directive -d 'Tracing directives' -r
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from label" -l json -d 'Output results as JSON'
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from label" -s v -l verbose -d 'Enable debug logs, -vv for trace'
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from label" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from orgs" -l api-addr -d 'The FlakeHub address to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from orgs" -l cache-addr -d 'The FlakeHub cache to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from orgs" -l frontend-addr -d 'The FlakeHub frontend address to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from orgs" -l logger -d 'Which logger to use' -r -f -a "{compact\t'',full\t'',pretty\t'',json\t''}"
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from orgs" -l log-directive -d 'Tracing directives' -r
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from orgs" -l json -d 'Output results as JSON'
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from orgs" -s v -l verbose -d 'Enable debug logs, -vv for trace'
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from orgs" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from releases" -l api-addr -d 'The FlakeHub address to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from releases" -l cache-addr -d 'The FlakeHub cache to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from releases" -l frontend-addr -d 'The FlakeHub frontend address to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from releases" -l logger -d 'Which logger to use' -r -f -a "{compact\t'',full\t'',pretty\t'',json\t''}"
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from releases" -l log-directive -d 'Tracing directives' -r
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from releases" -l json -d 'Output results as JSON'
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from releases" -s v -l verbose -d 'Enable debug logs, -vv for trace'
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from releases" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from versions" -l api-addr -d 'The FlakeHub address to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from versions" -l cache-addr -d 'The FlakeHub cache to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from versions" -l frontend-addr -d 'The FlakeHub frontend address to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from versions" -l logger -d 'Which logger to use' -r -f -a "{compact\t'',full\t'',pretty\t'',json\t''}"
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from versions" -l log-directive -d 'Tracing directives' -r
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from versions" -l json -d 'Output results as JSON'
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from versions" -s v -l verbose -d 'Enable debug logs, -vv for trace'
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from versions" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from help" -f -a "flakes" -d 'Lists all currently public flakes on FlakeHub'
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from help" -f -a "label" -d 'Lists all public flakes with the provided label'
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from help" -f -a "orgs" -d 'Lists all currently public organizations on FlakeHub'
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from help" -f -a "releases" -d 'List all releases for a specific flake on FlakeHub'
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from help" -f -a "versions" -d 'List all versions that match the provided version constraint'
complete -c fh -n "__fish_fh_using_subcommand list; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fh -n "__fish_fh_using_subcommand login" -l token-file -d 'Read the FlakeHub token from a file' -r -F
complete -c fh -n "__fish_fh_using_subcommand login" -l api-addr -d 'The FlakeHub address to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand login" -l cache-addr -d 'The FlakeHub cache to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand login" -l frontend-addr -d 'The FlakeHub frontend address to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand login" -l logger -d 'Which logger to use' -r -f -a "{compact\t'',full\t'',pretty\t'',json\t''}"
complete -c fh -n "__fish_fh_using_subcommand login" -l log-directive -d 'Tracing directives' -r
complete -c fh -n "__fish_fh_using_subcommand login" -l skip-status -d 'Skip following up a successful login with `fh status`'
complete -c fh -n "__fish_fh_using_subcommand login" -s v -l verbose -d 'Enable debug logs, -vv for trace'
complete -c fh -n "__fish_fh_using_subcommand login" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fh -n "__fish_fh_using_subcommand resolve" -l api-addr -d 'The FlakeHub address to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand resolve" -l cache-addr -d 'The FlakeHub cache to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand resolve" -l frontend-addr -d 'The FlakeHub frontend address to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand resolve" -l logger -d 'Which logger to use' -r -f -a "{compact\t'',full\t'',pretty\t'',json\t''}"
complete -c fh -n "__fish_fh_using_subcommand resolve" -l log-directive -d 'Tracing directives' -r
complete -c fh -n "__fish_fh_using_subcommand resolve" -l json -d 'Output the result as JSON displaying the store path plus the original attribute path'
complete -c fh -n "__fish_fh_using_subcommand resolve" -s v -l verbose -d 'Enable debug logs, -vv for trace'
complete -c fh -n "__fish_fh_using_subcommand resolve" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fh -n "__fish_fh_using_subcommand search" -s m -l max-results -d 'The maximum number of search results to return' -r
complete -c fh -n "__fish_fh_using_subcommand search" -l api-addr -d 'The FlakeHub address to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand search" -l cache-addr -d 'The FlakeHub cache to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand search" -l frontend-addr -d 'The FlakeHub frontend address to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand search" -l logger -d 'Which logger to use' -r -f -a "{compact\t'',full\t'',pretty\t'',json\t''}"
complete -c fh -n "__fish_fh_using_subcommand search" -l log-directive -d 'Tracing directives' -r
complete -c fh -n "__fish_fh_using_subcommand search" -l json -d 'Output results as JSON'
complete -c fh -n "__fish_fh_using_subcommand search" -s v -l verbose -d 'Enable debug logs, -vv for trace'
complete -c fh -n "__fish_fh_using_subcommand search" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fh -n "__fish_fh_using_subcommand status" -l api-addr -d 'The FlakeHub address to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand status" -l cache-addr -d 'The FlakeHub cache to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand status" -l frontend-addr -d 'The FlakeHub frontend address to communicate with' -r
complete -c fh -n "__fish_fh_using_subcommand status" -l logger -d 'Which logger to use' -r -f -a "{compact\t'',full\t'',pretty\t'',json\t''}"
complete -c fh -n "__fish_fh_using_subcommand status" -l log-directive -d 'Tracing directives' -r
complete -c fh -n "__fish_fh_using_subcommand status" -s v -l verbose -d 'Enable debug logs, -vv for trace'
complete -c fh -n "__fish_fh_using_subcommand status" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fh -n "__fish_fh_using_subcommand help; and not __fish_seen_subcommand_from add apply completion convert eject init list login resolve search status help" -f -a "add" -d 'Adds a flake input to your flake.nix'
complete -c fh -n "__fish_fh_using_subcommand help; and not __fish_seen_subcommand_from add apply completion convert eject init list login resolve search status help" -f -a "apply" -d 'Apply the configuration at the specified FlakeHub output reference to the current system'
complete -c fh -n "__fish_fh_using_subcommand help; and not __fish_seen_subcommand_from add apply completion convert eject init list login resolve search status help" -f -a "completion" -d 'Prints completion for shells to use'
complete -c fh -n "__fish_fh_using_subcommand help; and not __fish_seen_subcommand_from add apply completion convert eject init list login resolve search status help" -f -a "convert" -d 'Convert flake inputs to FlakeHub when possible'
complete -c fh -n "__fish_fh_using_subcommand help; and not __fish_seen_subcommand_from add apply completion convert eject init list login resolve search status help" -f -a "eject" -d 'Convert flake inputs from FlakeHub back to GitHub'
complete -c fh -n "__fish_fh_using_subcommand help; and not __fish_seen_subcommand_from add apply completion convert eject init list login resolve search status help" -f -a "init" -d 'Create a new flake.nix using an opinionated interactive initializer'
complete -c fh -n "__fish_fh_using_subcommand help; and not __fish_seen_subcommand_from add apply completion convert eject init list login resolve search status help" -f -a "list" -d 'Lists key FlakeHub resources'
complete -c fh -n "__fish_fh_using_subcommand help; and not __fish_seen_subcommand_from add apply completion convert eject init list login resolve search status help" -f -a "login" -d 'Log in to FlakeHub in order to allow authenticated fetching of flakes'
complete -c fh -n "__fish_fh_using_subcommand help; and not __fish_seen_subcommand_from add apply completion convert eject init list login resolve search status help" -f -a "resolve" -d 'Resolves a FlakeHub flake reference into a store path'
complete -c fh -n "__fish_fh_using_subcommand help; and not __fish_seen_subcommand_from add apply completion convert eject init list login resolve search status help" -f -a "search" -d 'Searches FlakeHub for flakes that match your query'
complete -c fh -n "__fish_fh_using_subcommand help; and not __fish_seen_subcommand_from add apply completion convert eject init list login resolve search status help" -f -a "status" -d 'Check your FlakeHub token status'
complete -c fh -n "__fish_fh_using_subcommand help; and not __fish_seen_subcommand_from add apply completion convert eject init list login resolve search status help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fh -n "__fish_fh_using_subcommand help; and __fish_seen_subcommand_from apply" -f -a "home-manager" -d 'Resolve the store path for a Home Manager configuration and run its activation script'
complete -c fh -n "__fish_fh_using_subcommand help; and __fish_seen_subcommand_from apply" -f -a "nix-darwin" -d 'Resolve the store path for a nix-darwin configuration and run its activation script'
complete -c fh -n "__fish_fh_using_subcommand help; and __fish_seen_subcommand_from apply" -f -a "nixos" -d 'Apply the resolved store path on a NixOS system'
complete -c fh -n "__fish_fh_using_subcommand help; and __fish_seen_subcommand_from list" -f -a "flakes" -d 'Lists all currently public flakes on FlakeHub'
complete -c fh -n "__fish_fh_using_subcommand help; and __fish_seen_subcommand_from list" -f -a "label" -d 'Lists all public flakes with the provided label'
complete -c fh -n "__fish_fh_using_subcommand help; and __fish_seen_subcommand_from list" -f -a "orgs" -d 'Lists all currently public organizations on FlakeHub'
complete -c fh -n "__fish_fh_using_subcommand help; and __fish_seen_subcommand_from list" -f -a "releases" -d 'List all releases for a specific flake on FlakeHub'
complete -c fh -n "__fish_fh_using_subcommand help; and __fish_seen_subcommand_from list" -f -a "versions" -d 'List all versions that match the provided version constraint'
