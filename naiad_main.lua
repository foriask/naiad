local naiad = "NAIAD"
local slogan = "The moonlike cli for anyone"
local version = "0.1a"

--[[
	This is just for ocasional use CLI.
	This aimt to have some functions:
	- Full program less than 16KB
	- Runs with iterated commands
	- Able to customize how it looks
	- Even supports colored terminals (maybe)
]]
local commands = {
	{
		-- This  is the bassics of a command, use it an example
		command = "version", -- ex. naiad version
		shortcut = "v", -- ex. naiad -v
		-- These are what it checks for, shortcut always has "-" at the start

		desc = "Shows the version of the program.",
		-- This is shown when used help command format
		-- Also when there is incorrect syntax

		to_do = {
			print(naiad .. " " .. version .. " - " .. slogan),
		}, -- Where args are handled, it follows the same structura, but if it laks command and shortcut it will use args directly in it.
		-- This can be just a standalone function
		args_number = 0, -- how many words after this are passed to "to_do" section
	},
	help = {
		-- Help needs to be a special command, with this name and definition, cause it's called in the main function (just to save time)
		format = {
			first = "Naiad is used with the commands below, followed by their respective arguments. ",
			last = "",	
			separator_one = " >> ",
			endline_one = "\n",
			endline_two = "\n",
			endline_three = "\n\n",
			per_command = function(_cmmd, _format)
				print(_format.endline_two .. _cmmd.name .. _format.separator_one .. _cmmd.desc)
			end,
		},
		all = function(_format, _commands)
			print(_format.first .. _format.endline_one)
			for _i, _cmmd in ipairs(_commands) do
				per_command(_cmmd, _format)
			end
			print(_format.endline_three .. _format.last),
		end,
	},
}

--[[
	Error cheatsheet:
	2 -> No command found, "help" is called
	3 -> Not enough arguments, "help _cmmd" is called



]]

local function working_naiad(_args, _commands)
	for _i, cmmd in ipairs(_commands) do -- Just iterate in the big command section
		if not ((_cmmd.command == _args[1]) or (_commd.command == _args[1])) then
			-- This checks if args (in this case, all of the command) coincides with one of the commands, if true, keep cheking until know what to do
			_commands.help.all()
			os.exit(2)
			return
		end
		if not (_cmmd.args_number == #_args) then
			_commands.help.this(_cmmd)
			os.exit(3)
			return
		end
	end
end
