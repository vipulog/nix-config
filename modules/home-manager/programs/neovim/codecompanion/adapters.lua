{
  gemini = function()
    return require("codecompanion.adapters").extend("gemini", {
      env = {
        api_key = "",
      },
      schema = {
        model = {
          default = "gemini-2.0-flash",
        },
      },
    })
  end
}
