
clc;
clear;
close all;

%% TEST 1: Actual binary mask
load('binary_mask.mat');
BW = logical(mask);

[lateral_error, heading_error, corner_ahead, ...
 circle_found, circle_offset, line_found] = B_geometry_v3(BW);

figure;
imshow(BW);
title('Test 1: Actual Binary Mask');

disp('TEST 1: ACTUAL MASK');
disp(['Lateral Error: ', num2str(lateral_error)]);
disp(['Heading Error: ', num2str(heading_error)]);
disp(['Corner Ahead: ', num2str(corner_ahead)]);
disp(['Circle Found: ', num2str(circle_found)]);
disp(['Circle Offset: ', num2str(circle_offset)]);
disp(['Line Found: ', num2str(line_found)]);


%% TEST 2: Straight line
BW = false(120,160);
BW(:,78:82) = true;

[lateral_error, heading_error, corner_ahead, ...
 circle_found, circle_offset, line_found] = B_geometry_v3(BW);

figure;
imshow(BW);
title('Test 2: Straight Line');

disp('TEST 2: STRAIGHT LINE');
disp([lateral_error, heading_error, corner_ahead, ...
      circle_found, circle_offset, line_found]);


%% TEST 3: Diagonal line
BW = false(120,160);

for r = 1:120
    c = round(40 + 0.5*r);
    BW(r,c-2:c+2) = true;
end

[lateral_error, heading_error, corner_ahead, ...
 circle_found, circle_offset, line_found] = B_geometry_v3(BW);

figure;
imshow(BW);
title('Test 3: Diagonal Line');

disp('TEST 3: DIAGONAL LINE');
disp([lateral_error, heading_error, corner_ahead, ...
      circle_found, circle_offset, line_found]);


%% TEST 4: Curved line
BW = false(120,160);

for r = 1:120
    c = round(80 + 0.004*(r-60)^2);
    BW(r,max(1,c-2):min(160,c+2)) = true;
end

[lateral_error, heading_error, corner_ahead, ...
 circle_found, circle_offset, line_found] = B_geometry_v3(BW);

figure;
imshow(BW);
title('Test 4: Curved Line');

disp('TEST 4: CURVED LINE');
disp([lateral_error, heading_error, corner_ahead, ...
      circle_found, circle_offset, line_found]);


%% TEST 5: Line with circle
BW = false(120,160);
BW(:,48:52) = true;

[X,Y] = meshgrid(1:160,1:120);
circle = (X-120).^2 + (Y-60).^2 <= 10^2;

BW = BW | circle;

[lateral_error, heading_error, corner_ahead, ...
 circle_found, circle_offset, line_found] = B_geometry_v3(BW);

figure;
imshow(BW);
title('Test 5: Line with Circle');

disp('TEST 5: LINE WITH CIRCLE');
disp([lateral_error, heading_error, corner_ahead, ...
      circle_found, circle_offset, line_found]);


%% TEST 6: No line
BW = false(120,160);

[lateral_error, heading_error, corner_ahead, ...
 circle_found, circle_offset, line_found] = B_geometry_v3(BW);

figure;
imshow(BW);
title('Test 6: No Line');

disp('TEST 6: NO LINE');
disp([lateral_error, heading_error, corner_ahead, ...
      circle_found, circle_offset, line_found]);

