function unsharpMasking(image)
    grayImage = rgb2gray(image);
    
    sigma = input('Enter sigma value: ');
    
    blurredImage = imgaussfilt(grayImage, sigma);
    
    unsharpMask = grayImage - blurredImage;
    
    sharpenedImage = grayImage + unsharpMask;
    
    sharpenedImage = max(0, min(sharpenedImage, 255));
    
    sharpenedImage = uint8(sharpenedImage);
    
    figure;
    subplot(1, 3, 1);
    imshow(grayImage);
    title('Original Grayscale Image');
    
    subplot(1, 3, 2);
    imshow(unsharpMask);
    title('Unsharp Mask');
    
    subplot(1, 3, 3);
    imshow(sharpenedImage);
    title('Sharpened Image (Unsharp Masking)');
end
