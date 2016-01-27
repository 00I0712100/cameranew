//
//  ViewController.m
//  seihoukei
//
//  Created by TomokoTakahashi on 2015/10/14.
//  Copyright (c) 2015年 高橋知子. All rights reserved.
//

#import "ViewController.h"


@interface ViewController (){
    UIImageView *whiteImage;
    UIImage * myImage;
    UIImageView *myImageView;
    UIButton *bt1;
    UIButton *bt2;
    UIButton *bt3;
    
    
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGRect rect1 = [[UIScreen mainScreen] bounds];
    
    whiteImage = [[UIImageView alloc] init];
    whiteImage.backgroundColor = [UIColor clearColor];
    whiteImage.frame = CGRectMake(0, rect1.size.height /2 -rect1.size.width /2, rect1.size.width, rect1.size.width);
    [self.view addSubview:whiteImage];
    
   // myImage = [UIImage imageNamed:@"image11.png"];
    myImageView =[[UIImageView alloc] initWithImage:self.takenImage];
    myImageView.frame = CGRectMake(0, rect1.size.height /2 -rect1.size.width /2, rect1.size.width, rect1.size.width);
    myImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:myImageView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
写真を撮る
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
    _myImageView.contentMode = UIViewContentModeScaleToFill;
}

-(IBAction)Fill:(id)sender{
       CGRect rect = CGRectMake(-4,self.whiteImageView.frame.origin.y, self.view.bounds.size.width+8, self.view.bounds.size.width+8);
    _myImageView.frame =rect;
    _myImageView.contentMode =UIViewContentModeScaleToFill;

}

-(IBAction)Seihoukei:(id)sender{
    CGRect rect = CGRectMake(0,self.myImageView.frame.origin.y, self.view.bounds.size.width, self.view.bounds.size.width);
    _myImageView.frame =rect;
    _myImageView.contentMode =UIViewContentModeScaleAspectFit;
}

-(IBAction)Sankaku:(id)sender{//直す
   CGRect rect = CGRectMake(15,self.myImageView.frame.origin.y, self.view.bounds.size.width - 30, self.view.bounds.size.width);
    _myImageView.frame =rect;
    _myImageView.contentMode =UIViewContentModeScaleAspectFit;
}
-(IBAction)Save:(id)sender{
     CGRect screenRect = [[UIScreen mainScreen] bounds];
    　screenRect =CGRectMake(0, screenRect.size.height /2 -screenRect.size.width /2, screenRect.size.width, screenRect.size.width);
    NSLog(@"CGRect ->%f %f %f %f",screenRect.origin.x, screenRect.origin.y, screenRect.size.width, screenRect.size.height);
    
    
    //直す
    
    UIGraphicsBeginImageContextWithOptions(screenRect.size, NO,1);
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
