local actor, super = Class(Actor, "knight")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Knight"

    -- Width and height for this actor, used to determine its center
    self.width = 90
    self.height = 90

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 0, 0}

    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "npcs/knight"

    self.default = "idle"

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of talk sprites and their talk speeds (default 0.25)
    self.talk_sprites = {}

    -- Table of sprite animations
    self.animations = {
        -- Looping animation with 0.25 seconds between each frame
        -- (even though there's only 1 idle frame)
        ["idle"] = {"idle", 0.10, true},
        ["crescent_slash"] = {"crescent_slash", 0.10, false},
        ["flurry"] = {"flurry", 1, false, next="flurry_execute"},
        ["flurry_execute"] = {"flurry_execute", 0.05, true},
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        ["idle"] = {-10,10},
        ["idle_troubled"] = {-10,10},
        ["flurry_execute"] = {-25,20}
    }
end

function actor:onSpriteUpdate(sprite)
    sprite.img_timer = (sprite.img_timer or 0) + DTMULT
    sprite.y = sprite.y + math.sin(Kristal.getTime() * 3 + 1) * 0.25
    if sprite.img_timer < 7 then return end
    sprite.img_timer = 0

    local afterimage = AfterImage(sprite, 0.5, 0.009)

    afterimage.physics.direction = 0
    afterimage.physics.speed = 1
    sprite.parent:addChild(afterimage)

end

return actor