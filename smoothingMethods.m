function smoothedImage = smoothingMethods(image)
    methodList = {'Average Filter', 'Weighted Filter', 'Median Filter', 'Max Filter', 'Min Filter'};
    
    [rows, cols] = size(image);
    filterSize = 3;
    padding = floor(filterSize / 2);
    
    smoothedImage = zeros(rows, cols);

    while true
        disp('Select a method:');
        for i = 1:numel(methodList)
            disp([num2str(i) '. ' methodList{i}]);
        end
        
        selection = input('Enter the number corresponding to the desired method (0 to exit): ');
        
        if selection == 0
            disp('Exiting.');
            return;
        end
        
        if selection < 1 || selection > numel(methodList)
            disp('Invalid selection. Please enter a number between 1 and 5.');
            continue;
        end
                
        paddedImage = padarray(image, [padding, padding], 0, 'both');
        
        sigma = 0; %intializing
        if selection == 2
            sigma = input('Enter the sigma value: '); % Example sigma value
        end
        
        smoothedImage = applyFilter(paddedImage, selection, filterSize, sigma);
        method = methodList{selection};
        
        showImages(image, smoothedImage, method);
    end
end

function smoothedImage = applyFilter(paddedImage, selection, filterSize, sigma)
    [rows, cols] = size(paddedImage);
    smoothedImage = zeros(rows - filterSize + 1, cols - filterSize + 1);

    for i = 1:rows - filterSize + 1
        for j = 1:cols - filterSize + 1
            neighborhood = paddedImage(i:i+filterSize-1, j:j+filterSize-1);
            if selection == 1
                average = mean(neighborhood(:));
            elseif selection == 2
                kernel = createGaussianKernel(sigma);
                average = sum(double(neighborhood(:)) .* double(kernel(:)));         
            elseif selection == 3
                average = median(neighborhood(:));                
            elseif selection == 4
                average = max(neighborhood(:));
            elseif selection == 5
                average = min(neighborhood(:));
            end
            smoothedImage(i, j) = average;
        end
    end
end

function kernel = createGaussianKernel(sigma)
    maskSize = 3; % Assuming fixed mask size for simplicity
    
    [X, Y] = meshgrid(-(maskSize-1)/2:(maskSize-1)/2, -(maskSize-1)/2:(maskSize-1)/2);
    
    kernel = exp(-(X.^2 + Y.^2) / (2*sigma^2));
    
    kernel = kernel / sum(kernel(:));
end

function showImages(originalImage, smoothedImage, method)
    figure;
    subplot(1, 2, 1);
    imshow(originalImage);
    title('Original Image');

    subplot(1, 2, 2);
    imshow(smoothedImage, []);
    title(['Smoothed Image - Method: ' method]);
end
