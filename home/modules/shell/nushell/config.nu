use std repeat

$env.EDITOR = "nvim"

const config_path 			= $nu.default-config-dir | path join "config";
const aliases_path 			= $config_path 	| path join "aliases";
const completions_path 	= $config_path 	| path join "completions";
const hooks_path 				= $config_path 	| path join "hooks";
const scripts_path 			= $config_path 	| path join "scripts";
const themes_path 			= $config_path 	| path join "themes";

# register aliases
source ($aliases_path | path join "git.nu");

# register completions
source ($completions_path | path join "git.nu");
source ($completions_path | path join "make.nu");

# register hooks
source ($hooks_path | path join "did_you_mean.nu")

# register scripts
source ($scripts_path | path join "nufetch.nu")

# register themes
source ($themes_path | path join "tokyo-night.nu")

$env.PATH = ($env.PATH |
	append /home/elisiei/bin |
	append /home/elisiei/go/bin
)

$env.COLORTERM = "truecolor"

$env.config = {
    buffer_editor: "nvim"
    edit_mode: "vi"
    show_banner: false
}

def create_left_prompt [] {
		# path
		let folder_name = (
        $env.PWD
        | str replace $env.HOME "~"
        | split row "/"
        | each {|it| $it }
        | str join "/"
        | $in
    )

		let folder = $"($folder_name)"
		let folder_colored = (
    	$folder | ansi gradient --fgstart '0xA0B6A0' --fgend '0x6C94DC'
		)

		let path_segment = $"(ansi bo)($folder_colored)(ansi reset)"

		# git
    let git_segment = (
        if (do -i { git rev-parse --is-inside-work-tree } | complete | get exit_code) == 0 {
            let branch = (do -i { git branch --show-current } | complete | get stdout | str trim)
            let changes = (do -i { git status --porcelain } | complete | get stdout | str trim)
            let status = if ($changes | is-empty) { "" } else { $" (ansi bo)(ansi '#FF6E7F')[!]" }
            $"(ansi i)on(ansi reset) (ansi bo)(ansi '#FBDBB6') ($branch)(ansi reset)($status)(ansi reset)"
        } else {
            ""
        }
    )

		# nix shell
    let nix_segment = (
        if ($env | columns | any {|c| $c == "IN_NIX_SHELL" }) and ($env.IN_NIX_SHELL | default "" | str trim | is-not-empty) {
            $"(ansi i)via(ansi reset) (ansi bo)(ansi '#A4CCB1')nix(ansi reset)"
        } else {
            ""
        }
    )

    # all
    [$path_segment $git_segment $nix_segment]
    | where {|x| not ($x | is-empty) }
    | str join " "
}


$env.PROMPT_COMMAND = { || create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = { || }

$env.PROMPT_INDICATOR_VI_INSERT = { || ": " }
$env.PROMPT_INDICATOR_VI_NORMAL = { || "! " }

$env.PROMPT_MULTILINE_INDICATOR = { || "::: " }

$env.PROMPT_INDICATOR = { ||
    let last_exit_code = $env.LAST_EXIT_CODE
    let indicator = if ($last_exit_code == 0) {
        $"(ansi cyan)❯(ansi reset)"
    } else {
        $"(ansi red)❯(ansi reset)"
    }
    $"\n($indicator) "
}
