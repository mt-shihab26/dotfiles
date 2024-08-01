local HOME = os.getenv "HOME"

local file = HOME .. "/.assets/wallpapers/go.jpg"

return {
    {
        source = { File = file },
        hsb = { hue = 1.0, saturation = 1.02, brightness = 0.03 },
        width = "100%",
        height = "100%",
    },
}
