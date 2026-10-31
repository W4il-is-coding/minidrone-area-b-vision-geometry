
clc;
clear;
close all;

rows = 240;
cols = 320;

%% TEST 1: STRAIGHT LINE

BW = false(rows,cols);
BW(:,158:162) = true;

test_geometry(BW,'Straight Line');


%% TEST 2: DIAGONAL LINE

BW = false(rows,cols);

for r = 1:rows
    c = round(100 + 0.25*r);

    BW(r,max(1,c-2):min(cols,c+2)) = true;
end

test_geometry(BW,'Diagonal Line');


%% TEST 3: CURVED LINE

BW = false(rows,cols);

for r = 1:rows
    c = round(160 + 0.002*(r-120)^2);

    BW(r,max(1,c-2):min(cols,c+2)) = true;
end

test_geometry(BW,'Curved Line');


%% TEST 4: LINE WITH LANDING CIRCLE

BW = false(rows,cols);

BW(:,158:162) = true;

[xx,yy] = meshgrid(1:cols,1:rows);

circle = (xx-230).^2 + (yy-60).^2 <= 15^2;

BW(circle) = true;

test_geometry(BW,'Line with Landing Circle');


%% TEST FUNCTION

function test_geometry(BW,name)

[lateral,heading,corner,circle,offset,line] = ...
    B_geometry_v3(BW);

figure;

imshow(BW);

title(name);

fprintf('\n%s\n',name);

fprintf('Lateral Error: %.2f\n',lateral);
fprintf('Heading Error: %.2f degrees\n',heading);
fprintf('Corner Ahead: %d\n',corner);
fprintf('Circle Found: %d\n',circle);
fprintf('Circle Offset: %.2f\n',offset);
fprintf('Line Found: %d\n',line);

end

