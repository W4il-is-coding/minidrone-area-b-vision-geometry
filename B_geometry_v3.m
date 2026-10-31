
function [lateral_error, heading_error, corner_ahead, ...
          circle_found, circle_offset, line_found] = B_geometry_v3(BW)
%#codegen

[rows, cols] = size(BW);

lateral_error = 0;
heading_error = 0;
corner_ahead = false;
circle_found = false;
circle_offset = 0;
line_found = false;

image_center = (cols + 1)/2;

% Divide image into three horizontal regions
top_sum = 0;
top_count = 0;

mid_sum = 0;
mid_count = 0;

bottom_sum = 0;
bottom_count = 0;

for r = 1:rows
    for c = 1:cols

        if BW(r,c)

            if r >= 0.20*rows && r <= 0.40*rows
                top_sum = top_sum + c;
                top_count = top_count + 1;

            elseif r >= 0.45*rows && r <= 0.60*rows
                mid_sum = mid_sum + c;
                mid_count = mid_count + 1;

            elseif r >= 0.70*rows && r <= 0.90*rows
                bottom_sum = bottom_sum + c;
                bottom_count = bottom_count + 1;
            end

        end
    end
end

% Line detection
if top_count + mid_count + bottom_count > 10
    line_found = true;
end

% Lateral error
if bottom_count > 0

    bottom_center = bottom_sum/bottom_count;

    lateral_error = bottom_center-image_center;

end

% Heading error
if top_count > 0 && bottom_count > 0

    top_center = top_sum/top_count;
    bottom_center = bottom_sum/bottom_count;

    dy = 0.5*rows;

    heading_error = atan2d( ...
        top_center-bottom_center,dy);

end

% Corner detection
if top_count > 0 && mid_count > 0 && bottom_count > 0

    top_center = top_sum/top_count;
    mid_center = mid_sum/mid_count;
    bottom_center = bottom_sum/bottom_count;

    expected_mid = (top_center+bottom_center)/2;

    if abs(mid_center-expected_mid) > 0.04*cols
        corner_ahead = true;
    end

end

% Landing circle detection
% Find separate connected components
[L, number] = bwlabel(BW,8);

if number > 0

    stats = regionprops(L,'Area','BoundingBox', ...
        'Eccentricity','Centroid');

    for k = 1:number

        area = stats(k).Area;
        bbox = stats(k).BoundingBox;
        eccentricity = stats(k).Eccentricity;

        width = bbox(3);
        height = bbox(4);

        if area >= 100 && width > 0 && height > 0

            aspect_ratio = width/height;

            if aspect_ratio >= 0.7 && aspect_ratio <= 1.3 ...
                    && eccentricity < 0.85

                circle_found = true;

                circle_offset = ...
                    stats(k).Centroid(1)-image_center;

            end
        end
    end
end

end


%[appendix]{"version":"1.0"}
%---
