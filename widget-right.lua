require 'cairo'

function conky_draw_bg()
    if conky_window == nil then return end
    local cs = cairo_xlib_surface_create(
        conky_window.display,
        conky_window.drawable,
        conky_window.visual,
        conky_window.width,
        conky_window.height
    )
    local cr = cairo_create(cs)

    local function rounded_rect(x, y, w, h, r, red, grn, blu, alpha)
        cairo_move_to(cr, x + r, y)
        cairo_line_to(cr, x + w - r, y)
        cairo_arc(cr, x + w - r, y + r, r, -math.pi/2, 0)
        cairo_line_to(cr, x + w, y + h - r)
        cairo_arc(cr, x + w - r, y + h - r, r, 0, math.pi/2)
        cairo_line_to(cr, x + r, y + h)
        cairo_arc(cr, x + r, y + h - r, r, math.pi/2, math.pi)
        cairo_line_to(cr, x, y + r)
        cairo_arc(cr, x + r, y + r, r, math.pi, 3*math.pi/2)
        
        -- Glass background
        cairo_set_source_rgba(cr, red, grn, blu, alpha)
        cairo_fill_preserve(cr)
        
        -- Glass border
        cairo_set_source_rgba(cr, 1.0, 1.0, 1.0, 0.18)
        cairo_set_line_width(cr, 1.0)
        cairo_stroke(cr)
    end

    -- Single clock box, full canvas
    rounded_rect(0, 0, 130, 145, 22, 0.05, 0.05, 0.05, 0.35)

    cairo_destroy(cr)
    cairo_surface_destroy(cs)
end
