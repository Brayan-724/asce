local MAX_ZOOM = 3
local MIN_ZOOM = 1
local ZOOM_TOGGLE_FACTOR = 2.0

---@param offset number
---@return nil
local function zoom(offset)
    local current = hl.get_config("cursor.zoom_factor")
    if offset ~= nil then
        current = current + offset
    elseif current ~= MIN_ZOOM then
        current = MIN_ZOOM
    else
        current = ZOOM_TOGGLE_FACTOR
    end
    current = math.max(MIN_ZOOM, math.min(MAX_ZOOM, current))
    hl.config({ cursor = { zoom_factor = current } })
end

hl.bind("SUPER + mouse:274", zoom)
hl.bind("SUPER + mouse_up", function()
    zoom(0.5)
end, {locked = true, repeating = true,})
hl.bind("SUPER + mouse_down", function()
    zoom(-0.5)
end, {locked = true, repeating = true,})

-----------------------

hl.layer_rule({
  match = {
    namespace = "sherlock",
  },
  dim_around = true,
  no_screen_share = true,
})
