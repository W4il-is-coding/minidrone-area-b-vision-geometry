
# Minidrone – Area B: Vision Geometry

## Project Overview

This repository contains the Area B implementation
of the MATLAB Minidrone competition project.

Area B converts binary images received from Area A
into geometric information required by Area C.

## Input

Binary image (BW):
- White pixels represent detected objects.
- Black pixels represent the background.

## Outputs

| Output | Description |
|---|---|
| lateral_error | Horizontal line displacement (pixels) |
| heading_error | Line direction (degrees) |
| corner_ahead | Corner detection flag |
| circle_found | Landing circle detection flag |
| circle_offset | Circle horizontal displacement |
| line_found | Line detection flag |

## Repository Structure

src/
- B_geometry_v1.m
- B_geometry_v2.m
- B_geometry_v3.m

tests/
- test_B_geometry_v3.m

## Testing

Synthetic test images are used to test:
1. Straight line
2. Diagonal line
3. Curved line
4. Line with landing circle

## Status

Initial prototype developed and tested
using synthetic binary images.

Real camera mask validation and code-generation
compatibility checks are pending.
