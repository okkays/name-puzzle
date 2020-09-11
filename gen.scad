use <fontmetrics.scad>; // https://www.thingiverse.com/thing:3004457

NAME = "JEREMIAH";
MAX_WIDTH = 200;
BASE_DEPTH = 2;
SLOT_DEPTH = 10;
BORDER_RADIUS=10;
PADDING = -4;
FONT_SPACING = 1;

FONT = "Liberation Mono";

module name(value, size, bold = true) {
  bold_font = str(FONT, ":style=Bold");
  text(
    value,
    size,
    spacing=FONT_SPACING,
    font = bold ? bold_font : FONT
  );
}

function namelen(value, size) = measureText(
    value,
    font=FONT,
    spacing=FONT_SPACING,
    size=size);

module name_box(value, width, base_depth, slot_depth, font_size) {
  module name_square() {
    minkowski() {
      circle(r=BORDER_RADIUS);
      translate([-PADDING, -PADDING, 0]) {
        square(
          [width + (2 * PADDING),
          font_size + (2 * PADDING)]
        );
      }
    }
  }

  translate([PADDING, PADDING, 0]) {
    linear_extrude(base_depth) {
      name_square();
    }
    linear_extrude(base_depth + slot_depth) {
      difference() {
        name_square();
        name(value, font_size);
      }
    }
  }
}

module name_3d(value, base_depth, slot_depth, font_size) {
  scale([1, 0.95, 1])
  translate([PADDING, PADDING + (0.025 * font_size), base_depth]) {
    linear_extrude(slot_depth) {
      name(NAME, font_size, bold = false);
    }
  }
}

font_size = MAX_WIDTH / len(NAME);
width = namelen(NAME, font_size);

name_box(NAME, width, BASE_DEPTH, SLOT_DEPTH, font_size);
name_3d(NAME, BASE_DEPTH, SLOT_DEPTH, font_size);
