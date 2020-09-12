use <fontmetrics.scad>; // https://www.thingiverse.com/thing:3004457

NAME = "JEREMIAH";
MAX_WIDTH = 220;
BASE_DEPTH = MAX_WIDTH / 100;
SLOT_DEPTH = MAX_WIDTH / 20;
BORDER_RADIUS= MAX_WIDTH / 20;
PADDING = -(MAX_WIDTH / 50);
FONT_SPACING = 1.1;
HEIGHT_SHRINKAGE = 0.00;

FONT = "Instruction";

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
  scale([1, 1 - HEIGHT_SHRINKAGE, 1])
  translate([PADDING, PADDING + ((HEIGHT_SHRINKAGE / 2) * font_size), base_depth]) {
    linear_extrude(slot_depth) {
      name(NAME, font_size, bold = false);
    }
  }
}

font_size = MAX_WIDTH / len(NAME);
width = namelen(NAME, font_size);

name_box(NAME, width, BASE_DEPTH, SLOT_DEPTH, font_size);
translate([0, font_size + abs(2 * PADDING), -BASE_DEPTH])
name_3d(NAME, BASE_DEPTH, SLOT_DEPTH, font_size);
