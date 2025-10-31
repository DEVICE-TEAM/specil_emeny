local Ach, super = Class(Achievement)

function Ach:init()
    super.init(self)
    
    self.name = "YOUR TAKING TOO LONG" -- Display name

    self.iconanimated = false -- If icons should be animated, if true then the input for both icons should be a table of paths
    self.icon = "achievements/generic"
    self.desc = "Take too long." -- Description
    self.hidden = false -- Doesn't show up in the menu if not collected
    self.rarity = "Epic" -- An indicator on how difficult this achievement is. "Common", "Uncommon", "Rare", "Epic" "Legendary", "Unique", "Impossible"
    self.completion = false -- Shows a percent indicator if true, shows x/int if an integer, nothing if false.
    self.index = 9 -- Order in which the achievements will show up on the menu.
end

return Ach