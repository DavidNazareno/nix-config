local colors = require("colors").sections.bar

-- Equivalent to the --bar domain
sbar.bar {
  topmost = "window",
  height = 40,
  color = colors.bg,
  padding_right = 0,
  padding_left = 0,
  margin = 0,
  corner_radius = 0,
  y_offset = 0,
  border_color = colors.border,
  border_width = 0,
  blur_radius = 32,
}
