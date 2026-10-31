
function [lateral_error, heading_error, corner_ahead, ...
    circle_found, circle_offset, line_found] = B_geometry_v2(BW)
%#codegen

[rows, cols] = size(BW);

lower_sum = 0;
lower_count = 0;

upper_sum = 0;
upper_count = 0;

lateral_error = 0;
heading_error = 0;
corner_ahead = false;

circle_found = false;
circle_offset = 0;

line_found = false;

mid = floor(rows/2);

% Calculate centroid in upper and lower image regions

for r = 1:rows
    for c = 1:cols

        if BW(r,c)

            if r <= mid
                upper_sum = upper_sum + c;
                upper_count = upper_count + 1;
            else
                lower_sum = lower_sum + c;
                lower_count = lower_count + 1;
            end

        end

    end
end

% Check whether line is detected

if upper_count > 0 || lower_count > 0
    line_found = true;
end

% Calculate lateral error using lower half

if lower_count > 0

    lower_center = lower_sum/lower_count;
    image_center = (cols+1)/2;

    lateral_error = lower_center-image_center;

end

% Calculate heading error

if upper_count > 0 && lower_count > 0

    upper_center = upper_sum/upper_count;
    lower_center = lower_sum/lower_count;

    dy = rows-mid;

    heading_error = atan2d(upper_center-lower_center,dy);

    % Basic corner warning

    if abs(upper_center-lower_center) > 0.05*cols
        corner_ahead = true;
    end

end

end


%[appendix]{"version":"1.0"}
%---
