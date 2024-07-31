local HOME = os.getenv("HOME")

local file = HOME .. "/.assets/wallpapers/hacking.jpg"

-- file = "/Users/shihab/.assets/wallpapers/hacking.jpg"

local background = {
	{
		source = { File = file },
		hsb = { hue = 1.0, saturation = 1.02, brightness = 0.04 },
		width = "100%",
		height = "100%",
	},
}

return background
