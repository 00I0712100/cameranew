//
//  ViewController.m
//  seihoukei
//
//  Created by TomokoTakahashi on 2015/10/14.
//  Copyright (c) 2015年 高橋知子. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // s_imageView.frame = ;
//    [[CameraManager sharedManager] startCamera:(GPUImageView *)self.cameraView];
//    
//}
//
//
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    self.cameraView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill;
//    
//}
//-(IBAction)performShutterButtonAction:(UIBarButtonItem *)sender
//{
//    [[CameraManager sharedManager]takePhoto];
//    
//}
//-(IBAction)performSwitchCameraButtonAction:(UIButton *)sender
//{
//    [[CameraManager sharedManager] switchCameraPosition:self.cameraView];
//    
//}
//-(IBAction)performPreviousButtonAction:(UIBarButtonItem *)sender
//{
//    [[CameraManager sharedManager] setPreviousFilter:self.cameraView];
//}
//-(IBAction)performNextButtonAction:(UIBarButtonItem *)sender
//{
//    //変える
//    [[CameraManager sharedManager] setPreviousFilter:self.cameraView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
//写真を撮る
-(IBAction)Camera:(id)sender{
    //カメラの利用
    UIImagePickerControllerSourceType sourcetype = UIImagePickerControllerSourceTypeCamera;
    //カメラの利用可能かチェック
    if ([UIImagePickerController isSourceTypeAvailable:sourcetype]){
        //インスタンス確認
        UIImagePickerController *cameraPicker = [[UIImagePickerController alloc]init];
        cameraPicker.sourceType = sourcetype;
        cameraPicker.delegate = self;
        [self presentViewController:cameraPicker animated:YES completion:nil];
         
        
    }
}
 
 */




//撮影後の処理
-(void)imagePickerController:(UIImagePickerController *)imagePicker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *cameraImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    [_myImageView setImage:cameraImage];
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
    
    
}


-(IBAction)CameraRoll:(id)sender{
    UIImagePickerController *imgpic = [[UIImagePickerController alloc] init];
    imgpic.delegate = self;
    [imgpic setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController: imgpic animated:YES completion:nil];
    
}


-(void)imagePickerContyoller:(UIImagePickerController *)picker
        didFinishPickerImage:(UIImage *)image editingInfon :(NSDictionary *)editingInfo {
    [self.myImageView setImage:image];
    [self dismissViewControllerAnimated:YES completion:nil];
    _myImageView.contentMode = UIViewContentModeScaleAspectFill;
}



-(IBAction)Seihoukei:(id)sender{
    CGRect rect = CGRectMake(0,118,320,320);
    _myImageView.frame =rect;
    _myImageView.contentMode =UIViewContentModeScaleAspectFit;
}
-(IBAction)Fill:(id)sender{
    CGRect rect = CGRectMake(0,118,320,320);
    _myImageView.frame =rect;
    _myImageView.contentMode =UIViewContentModeScaleAspectFill;

}
-(IBAction)Sankaku:(id)sender{
    CGRect rect = CGRectMake(20,118,280,280);
    _myImageView.frame =rect;
    _myImageView.contentMode =UIViewContentModeScaleAspectFit;
}
-(IBAction)Save:(id)sender{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    screenRect =CGRectMake(0, 166, 320, 320);
    NSLog(@"CGRect ->%f %f %f %f",screenRect.origin.x, screenRect.origin.y, screenRect.size.width, screenRect.size.height);
    
    UIGraphicsBeginImageContextWithOptions(screenRect.size, NO,0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor blackColor]set];
    CGContextFillRect(ctx,screenRect);
    
    [self.view.layer renderInContext:ctx];
    
    NSData *pngDate = UIImagePNGRepresentation(UIGraphicsGetImageFromCurrentImageContext());
    UIImage *screenImage = [UIImage imageWithData:pngDate];
    
    UIActivityViewController *activityView = [[UIActivityViewController alloc] initWithActivityItems:@[screenImage]applicationActivities:@[] ];
    
    [self presentViewController:activityView animated:YES completion:nil];
    
    
    
}










@end
