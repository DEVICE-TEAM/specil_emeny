local Ramb, super = Class(Actor, "ramb")

function Ramb:init()
    super.init(self)

    self.name = "Ramb"

    self.width = 25
    self.height = 32

    self.color = {1, 0, 0}

    self.hitbox = {nil, 20, 25, 12}

    self.path = "npcs/ramb"
    self.default = "body"

end

function Ramb:onSpriteInit(sprite)

    sprite.y = sprite.y + 20

    sprite.head = Sprite("happy", 0, 0, nil, nil, self.path .. "/head")
    sprite.head.y, sprite.head.x = sprite.head.y - 19, sprite.head.x - 2
    sprite:addChild(sprite.head)

end

return Ramb