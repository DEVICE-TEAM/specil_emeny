local Ach, super = Class(Achievement)

function Ach:init()
    super.init(self)
    
    self.name = "In These Trying Times..." -- Display name

    self.iconanimated = false -- If icons should be animated, if true then the input for both icons should be a table of paths
    self.icon = "achievements/generic"
    self.desc = "You achieved the eggding." -- Description
    self.hint = "Can I offer you a nice egg in this trying\ntime?" -- If info hidden is true then this will show up in place of description, used for hints
    self.hidden = true -- Doesn't show up in the menu if not collected
    self.rarity = "Epic" -- An indicator on how difficult this achievement is. "Common", "Uncommon", "Rare", "Epic" "Legendary", "Unique", "Impossible"
    self.completion = false -- Shows a percent indicator if true, shows x/int if an integer, nothing if false.
    self.index = 2 -- Order in which the achievements will show up on the menu.
end

return Ach