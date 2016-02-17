//
//  ViewController.m
//  seihoukei
//
//  Created by TomokoTakahashi on 2015/10/14.
//  Copyright (c) 2015年 高橋知子. All rights reserved.
//

#import "ViewController.h"


@interface ViewController (){
    //UIImageView *whiteImage;
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
//    whiteImage = [[UIImageView alloc] init];
//    whiteImage.backgroundColor = [UIColor clearColor];
//    whiteImage.frame = CGRectMake(0, rect1.size.height / 2 - rect1.size.width / 2, rect1.size.width, rect1.size.height);
//    [self.view addSubview:whiteImage];
    
   // myImage = [UIImage imageNamed:@"image11.png"];
    myImageView =[[UIImageView alloc] init];
    myImageView.frame = CGRectMake(0, rect1.size.height /2 -rect1.size.width /2, rect1.size.width, rect1.size.width);
    NSLog(@"CGRect ->%f %f %f %f",rect1.origin.x, rect1.origin.y, rect1.size.width, rect1.size.height);

    myImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:myImageView];
    
    
    NSLog(@"UIImageViewのサイズは...%f", _myImageView.bounds.size.height);
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
    _myImageView.contentMode = UIViewContentModeScaleAspectFill;

    
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

-(IBAction)Fill:(id)sender{
    CGRect screen =[[UIScreen mainScreen]bounds];
    CGRect rect = CGRectMake(0,screen.size.height / 2 - screen.size.width / 2,screen.size.width,screen.size.width);
    _myImageView.frame =rect;
    _myImageView.contentMode =UIViewContentModeScaleAspectFill;

    NSLog(@"%f", _myImageView.bounds.size.height);
}

-(IBAction)Seihoukei:(id)sender{
    CGRect screen =[[UIScreen mainScreen]bounds];

    CGRect rect = CGRectMake(0,screen.size.height / 2 - screen.size.width / 2,screen.size.width,screen.size.width);
    NSLog(@"CGRect ->%f %f %f %f",rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
    _myImageView.frame =rect;
    _myImageView.contentMode =UIViewContentModeScaleAspectFit;
}

-(IBAction)Sankaku:(id)sender{//直した！
    CGRect screen =[[UIScreen mainScreen]bounds];
    _myImageView.frame = CGRectInset(myImageView.bounds, 20, 20);
    _myImageView.center = CGPointMake( screen.size.width / 2,screen.size.height / 2);
    _myImageView.contentMode = UIViewContentModeScaleAspectFit;
}

-(IBAction)Save:(id)sender{
    
    CGRect screenRect =CGRectMake(0, self->myImageView.frame.origin.y, self->myImageView.frame.size.width, self->myImageView.frame.size.width);
//    
//    NSLog(@"CGRect ->%f %f %f %f",screenRect.origin.x, screenRect.origin.y, screenRect.size.width, screenRect.size.height);
//
    
      //画質を良くした
    UIGraphicsBeginImageContextWithOptions(_myImageView.frame.size, NO,0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGContextTranslateCTM(ctx, 0, -self->myImageView.frame.origin.y);
    
    CGContextSetFillColorWithColor(ctx, [[UIColor whiteColor] CGColor]);
    [[UIColor whiteColor] set];
    CGContextFillRect(ctx, CGRectMake(0, 0, _myImageView.frame.size.width, _myImageView.frame.size.width));
    
    
    [self.myImageView.layer renderInContext:ctx];
    
    UIImage *screenImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIActivityViewController *activityView = [[UIActivityViewController alloc] initWithActivityItems:@[screenImage]applicationActivities:@[] ];
    
    [self presentViewController:activityView animated:YES completion:nil];
 
    
    
}







@end
