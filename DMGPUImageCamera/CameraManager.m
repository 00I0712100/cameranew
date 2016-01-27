//
//  CameraManager.m
//  GPUImageSampler
//
//  Created by Masuhara on 2015/12/09.
//  Copyright © 2015年 Daisuke Masuhara. All rights reserved.
//

#import "CameraManager.h"
#import "ViewController.h"

@interface CameraManager()

@property(nonatomic, strong)GPUImageStillCamera *stillCamera;
@property(nonatomic, strong)NSArray *filterArray;
@property(nonatomic, strong)GPUImageFilter *currentFilter;
@property(readwrite)AVCaptureDevicePosition cameraPosition;

@end

@implementation CameraManager


//盛れるフィルター

+ (instancetype)sharedManager {
    static id manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (id)init {
    self = [super init];
    if (self) {
        _cameraPosition = AVCaptureDevicePositionFront;
        [self initializeFilter];
    }
    return self;
}

- (void)initializeFilter {
    NSMutableArray *filterArray = [NSMutableArray array];
    [filterArray addObject:[[GPUImageSepiaFilter alloc] init]];
    [filterArray addObject:[[GPUImageGrayscaleFilter alloc] init]];
    [filterArray addObject:[[GPUImageHalftoneFilter alloc] init]];
    [filterArray addObject:[[GPUImageSketchFilter alloc] init]];
    [filterArray addObject:[[GPUImagePixellateFilter alloc] init]];
    [filterArray addObject:[[GPUImageTiltShiftFilter alloc] init]];
    self.filterArray = filterArray;
    ope = 0;
}

- (void)startCamera:(GPUImageView *)imageView {
    self.stillCamera = [[GPUImageStillCamera alloc] initWithSessionPreset:AVCaptureSessionPresetPhoto cameraPosition:self.cameraPosition];
    self.stillCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
        [self.stillCamera startCameraCapture];
    self.stillCamera.horizontallyMirrorFrontFacingCamera = YES;
    NSInteger index = [self currentFilterIndex];
    [self setFilter:index imageView:imageView];
    [self.stillCamera startCameraCapture];
    
    
}

- (void)stopCamera {
    if (self.stillCamera) {
        [self.stillCamera stopCameraCapture];
        self.stillCamera = nil;
    }
}

- (void)switchCameraPosition:(GPUImageView *)imageView {
    [self stopCamera];
    if (self.cameraPosition == AVCaptureDevicePositionFront) {
        self.cameraPosition = AVCaptureDevicePositionBack;
    }else {
        self.cameraPosition = AVCaptureDevicePositionFront;
        
    }
    
    [self startCamera:imageView];
}

- (void)setPreviousFilter:(GPUImageView *)imageView {
    NSInteger index = [self previousFilterIndex];
    [self setFilter: index imageView: imageView];
}

- (void)setNextFilter: (GPUImageView *)imageView {
    NSInteger index = [self nextFilterIndex];
    [self setFilter: index imageView:imageView];
}

- (void)setFilter: (NSInteger)index imageView: (GPUImageView *)imageView {
    GPUImageFilter *filter = self.filterArray[index];
    [self removeTarget: imageView];
    self.currentFilter = filter;
    [self applyFilter: imageView];
}

- (NSInteger)currentFilterIndex {
    if(ope == 0){
        ope++;
        return 0;
    }else{
        return [self.filterArray indexOfObject:self.currentFilter];
    }
    
}

- (NSInteger)previousFilterIndex {
    NSInteger index = [self currentFilterIndex];
    index--;
    if (index < 0) {
        index = self.filterArray.count - 1;
    }
    
    return index;
}

- (NSInteger)nextFilterIndex {
    NSInteger index = [self currentFilterIndex];
    index++;
    if (index >= self.filterArray.count) {
        index = 0;
    }
    return index;
}

- (void)removeTarget: (GPUImageView *)view {
    if (self.currentFilter) {
        [self.stillCamera removeTarget:self.currentFilter];
        [self.currentFilter removeTarget:view];
    }
}

- (void)applyFilter: (GPUImageView *)view {
    [self.stillCamera addTarget:self.currentFilter];
    [self.currentFilter addTarget:view];
}

- (void)takePhoto {
    [self.stillCamera capturePhotoAsImageProcessedUpToFilter:self.currentFilter
                                       withCompletionHandler:^(UIImage *processedImage, NSError *error) {
     if (!error) {
         UIImageWriteToSavedPhotosAlbum(processedImage, self, @selector(image: didFinishSavingWithError: contextInfo: ), nil);

     }
     
     }];
}

- (void)image:(UIImage *)image didFinishSavingWithError: (NSError *)error contextInfo: (void *)contextInfo {
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"写真の保存に失敗しました" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
    }
}




@end




