//
//  CameraViewController.m
//  seihoukei
//
//  Created by TomokoTakahashi on 2015/12/09.
//  Copyright © 2015年 高橋知子. All rights reserved.
//

#import "CameraViewController.h"
#import "CameraManager.h"

@interface CameraViewController ()

@property (weak,nonatomic) IBOutlet GPUImageView *cameraView;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // s_imageView.frame = ;
    [[CameraManager sharedManager] startCamera:(GPUImageView *)self.cameraView];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.cameraView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill;
    
}
-(IBAction)performShutterButtonAction:(UIBarButtonItem *)sender
{
    [[CameraManager sharedManager]takePhoto];
    
}
-(IBAction)performSwitchCameraButtonAction:(UIButton *)sender
{
    [[CameraManager sharedManager] switchCameraPosition:self.cameraView];
    
}
-(IBAction)performPreviousButtonAction:(UIBarButtonItem *)sender
{
    [[CameraManager sharedManager] setPreviousFilter:self.cameraView];
}
-(IBAction)performNextButtonAction:(UIBarButtonItem *)sender
{
    //変える
    [[CameraManager sharedManager] setPreviousFilter:self.cameraView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
