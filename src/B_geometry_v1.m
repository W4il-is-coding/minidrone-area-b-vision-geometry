
function [lateral_error, line_found] = B_geometry_v1(BW)
%#codegen

[rows, cols] = size(BW);

sumX = 0;
count = 0;

lateral_error = 0;
line_found = false;

for r = 1:rows
    for c = 1:cols
        if BW(r,c)
            sumX = sumX + c;
            count = count + 1;
        end
    end
end

if count > 0
    line_found = true;

    line_center = sumX / count;
    image_center = (cols + 1) / 2;

    lateral_error = line_center - image_center;
end

end

