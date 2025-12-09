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
			function(_args)
				print(_args)
				print(naiad .. " " .. version .. " - " .. slogan)
			end,
		}, -- Where args are handled, it follows the same structura, but if it laks command and shortcut it will use args directly in it.
		-- This can be just a standalone function
		args_number = 0, -- how many words after this are passed to "to_do" section
	},
	help = {
		-- Help needs to be a special command, with this name and definition, cause it's called in the main function (just to save time)
		command = "help",
		shortcut = "h",
		format = {
			first = "Naiad is used with the commands below, followed by their respective arguments. ",
			last = "",
			separator_one = " | ",
			separator_two = " >> ",
			endline_one = "\n",
			endline_two = "\n",
			endline_three = "\n",
			per_command = function(_cmmd, _format)
				-- local _raw_second = string.sub(_cmmd.command, 2)
				-- local _raw_first = string.upper(string.sub(_cmmd.command, 0, 1))
				-- print(_format.endline_two .. _raw_first .. _raw_second .. _format.separator_one .. _cmmd.desc)
				print(
					_format.endline_two
						.. _cmmd.command
						.. _format.separator_one
						.. _cmmd.shortcut
						.. _format.separator_two
						.. _cmmd.desc
				)
			end,
			-- Per command is executed with EVERY command in this list. Maybe someday it will work with groups
		},
		all = function(_format, _commands)
			print(_format.first .. _format.endline_one)
			for _i, _cmmd in ipairs(_commands) do
				_format.per_command(_cmmd, _format)
			end
			print(_format.endline_three .. _format.last)
		end,
		-- This function grabs all commands and pick their information, that's why "desc" is important
	},
}

--[[
	Error cheatsheet:
	2 -> No command found, "help" is called
	3 -> Not enough arguments, "help _cmmd" is called



]]

local function working_naiad(_args, _commands)
	for _i, _cmmd in ipairs(_commands) do -- Just iterate in the big command section
		if not ((_cmmd.command == _args[1]) or (_cmmd.shortcut == _args[1])) then
			-- This checks if args (in this case, all of the command) coincides with one of the commands, if true, keep cheking until know what to do
			_commands.help.all(_commands.help.format, _commands)
			os.exit(2)
			return
		end
		if not (_cmmd.args_number == #_args - 1) then
			-- Now, checks for the correct number of arguments, ignoring the command itself
			_commands.help.this(_cmmd)
			os.exit(3)
			return
		end
		local _usefull_args = { "" }
		for _y = 2, _cmmd.args_number + 1 do
			-- We ignore the first argument, because it is the command itself, after that, pick all and add it to the "_usefull_args" local var
			table.insert(_usefull_args, _args[_y])
		end
		_cmmd.to_do[1](table.concat(_usefull_args))
	end
end

working_naiad(arg, commands)
