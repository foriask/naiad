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
}

local function working_naiad(_args, _commands)


