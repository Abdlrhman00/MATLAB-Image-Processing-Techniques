function smoothedImage = smoothingMethods(image)
    % Define a list of filtering methods
    methodList = {'Average Filter', 'Weighted Filter', 'Median Filter', 'Max Filter', 'Min Filter'};
    
    % Get the size of the input image
    [rows, cols] = size(image);
    
    % Define filter size and padding
    filterSize = 3;
    padding = floor(filterSize / 2);
    
    % Initialize the output image
    smoothedImage = zeros(rows, cols);

    % Loop to select and apply filtering method
    while true
        disp('Select a method:');
        for i = 1:numel(methodList)
            disp([num2str(i) '. ' methodList{i}]);
        end
        
        % User selects a filtering method
        selection = input('Enter the number corresponding to the desired method (0 to exit): ');
        
        % Exit if 0 is entered
        if selection == 0
            disp('Exiting.');
            return;
        end
        
        % Check for valid selection
        if selection < 1 || selection > numel(methodList)
            disp('Invalid selection. Please enter a number between 1 and 5.');
            continue;
        end
                
        % Pad the image
        paddedImage = padarray(image, [padding, padding], 0, 'both');
        
        % Ask for sigma value if Weighted Filter is selected
        sigma = 0; % Initialize sigma
        if selection == 2
            sigma = input('Enter the sigma value: '); % Example sigma value
        end
        
        % Apply selected filtering method
        smoothedImage = applyFilter(paddedImage, selection, filterSize, sigma);
        method = methodList{selection};
        
        % Display original and smoothed images
        showImages(image, smoothedImage, method);
    end
end

% Function to apply selected filter
function smoothedImage = applyFilter(paddedImage, selection, filterSize, sigma)
    % Get size of padded image
    [rows, cols] = size(paddedImage);
    
    % Initialize output image
    smoothedImage = zeros(rows - filterSize + 1, cols - filterSize + 1);

    % Loop through each pixel in the image
    for i = 1:rows - filterSize + 1
        for j = 1:cols - filterSize + 1
            % Extract neighborhood around current pixel
            neighborhood = paddedImage(i:i+filterSize-1, j:j+filterSize-1);
            % Apply selected filtering method
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
            % Assign the result to the corresponding pixel in the output image
            smoothedImage(i, j) = average;
        end
    end
end

% Function to create Gaussian kernel
function kernel = createGaussianKernel(sigma)
    % Define mask size
    maskSize = 3; % Assuming fixed mask size for simplicity
    
    % Create meshgrid for x and y coordinates
    [X, Y] = meshgrid(-(maskSize-1)/2:(maskSize-1)/2, -(maskSize-1)/2:(maskSize-1)/2);
    
    % Compute Gaussian distribution
    kernel = exp(-(X.^2 + Y.^2) / (2*sigma^2));
    
    % Normalize the kernel
    kernel = kernel / sum(kernel(:));
end

% Function to display original and smoothed images
function showImages(originalImage, smoothedImage, method)
    figure;
    subplot(1, 2, 1);
    imshow(originalImage);
    title('Original Image');

    subplot(1, 2, 2);
    imshow(smoothedImage, []);
    title(['Smoothed Image - Method: ' method]);
end
