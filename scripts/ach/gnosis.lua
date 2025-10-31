local Ach, super = Class(Achievement)

function Ach:init()
    super.init(self)
    
    self.name = "Gnosis" -- Display name

    self.iconanimated = false -- If icons should be animated, if true then the input for both icons should be a table of paths
    self.icon = "achievements/generic"
    self.desc = "Received her gift." -- Description
    self.hint = ""
    self.hidden = true -- Doesn't show up in the menu if not collected
    self.rarity = "Legendary" -- An indicator on how difficult this achievement is. "Common", "Uncommon", "Rare", "Epic" "Legendary", "Unique", "Impossible"
    self.completion = false -- Shows a percent indicator if true, shows x/int if an integer, nothing if false.
    self.index = 7 -- Order in which the achievements will show up on the menu.
end

return Ach