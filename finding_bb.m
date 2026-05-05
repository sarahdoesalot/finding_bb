%%%%%%%%%%%%%%%%%%%%%%%% HEADER %%%%%%%%%%%%%%%%%%%%%%%%
%Name: finding_bb.m
%Writer: S. Marchand
%Lab: CerCo - Toulouse, France
%Last update: 05/04/2026
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Choose your file
[filename, pathname] = uigetfile('*.nii', 'Select your .nii image');
if isequal(filename,0)
    disp('User canceled');
else
    nii_path = fullfile(pathname, filename);

    %Read the image information
    V = spm_vol(nii_path);
    corners_vox = [
        1          1          1;
        V.dim(1)   1          1;
        1          V.dim(2)   1;
        1          1          V.dim(3);
        V.dim(1)   V.dim(2)   1;
        V.dim(1)   1          V.dim(3);
        1          V.dim(2)   V.dim(3);
        V.dim(1)   V.dim(2)   V.dim(3);
        ];

    % Transform to mm
    corners_mm = V.mat(1:3, :) * [corners_vox'; ones(1,8)];

    % Bounding box : [min; max]
    bounding_box = [min(corners_mm, [], 2)'; max(corners_mm, [], 2)'];

    fprintf('\nBounding box of %s:\n', filename);
    disp(bounding_box);
end