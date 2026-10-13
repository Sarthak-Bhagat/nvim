-- Colour preview: the text of each colour is drawn in that colour (foreground, as the
-- old nvim-colorizer setup did). Replaces nvim-colorizer and custom/color_preview.lua,
-- whose `[r, g, b, a]` arrays are kept here and now update live as the buffer changes.
local hipatterns = require "mini.hipatterns"

local function fg(hex)
  return hipatterns.compute_hex_color_group(hex, "fg")
end

-- "#rrggbb" from three 0-255 components; nil when any is out of range.
local function from_rgb(r, g, b)
  r, g, b = tonumber(r), tonumber(g), tonumber(b)
  if not (r and g and b) or r > 255 or g > 255 or b > 255 then
    return nil
  end
  return string.format("#%02x%02x%02x", r, g, b)
end

-- A highlighter whose group comes from `to_hex(full_match)`; no colour, no highlight.
local function colour(pattern, to_hex)
  return {
    pattern = pattern,
    group = function(_, _, data)
      local hex = to_hex(data.full_match)
      return hex and fg(hex) or nil
    end,
  }
end

return {
  highlighters = {
    -- #rrggbb and #rrggbbaa (alpha ignored)
    hex = colour("#%x%x%x%x%x%x%x?%x?%f[%X]", function(m)
      return (#m == 7 or #m == 9) and m:sub(1, 7) or nil
    end),
    -- #rgb
    hex_short = colour("#%x%x%x%f[%X]", function(m)
      local r, g, b = m:sub(2, 2), m:sub(3, 3), m:sub(4, 4)
      return "#" .. r .. r .. g .. g .. b .. b
    end),
    -- 0xAARRGGBB
    argb = colour("0x%x%x%x%x%x%x%x%x%f[%X]", function(m)
      return "#" .. m:sub(5, 10)
    end),
    -- rgb(r, g, b) and rgba(r, g, b, a)
    rgb_fn = colour("rgba?%(%s*%d+%s*,%s*%d+%s*,%s*%d+[^)]*%)", function(m)
      return from_rgb(m:match "%(%s*(%d+)%s*,%s*(%d+)%s*,%s*(%d+)")
    end),
    -- [r, g, b, a] arrays, his format (alpha ignored)
    rgba_array = colour("%[%s*%d+%s*,%s*%d+%s*,%s*%d+%s*,%s*[%d%.]+%s*%]", function(m)
      return from_rgb(m:match "%[%s*(%d+)%s*,%s*(%d+)%s*,%s*(%d+)")
    end),
  },
}
