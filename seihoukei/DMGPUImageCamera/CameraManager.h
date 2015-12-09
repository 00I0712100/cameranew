//
//  CameraManager.h
//  GPUImageSampler
//
//  Created by Masuhara on 2015/12/09.
//  Copyright © 2015年 Daisuke Masuhara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GPUImage/GPUImage.h>

@interface CameraManager : NSObject

+ (instancetype)sharedManager;

- (void)startCamera: (GPUImageView *)imageView;
- (void)stopCamera;

- (void)switchCameraPosition: (GPUImageView *)imageView;
- (void)setPreviousFilter: (GPUImageView *)imageView;

- (void)takePhoto;

@end
