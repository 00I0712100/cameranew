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
    UIButton *bt1;
    UIButton *bt2;
    UIButton *bt3;
    
    int number;
    
    
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    number=0;
    // Do any additional setup after loading the view, typically from a nib.
    CGRect rect1 = [[UIScreen mainScreen] bounds];
//    whiteImage = [[UIImageView alloc] init];
//    whiteImage.backgroundColor = [UIColor clearColor];
//    whiteImage.frame = CGRectMake(0, rect1.size.height / 2 - rect1.size.width / 2, rect1.size.width, rect1.size.height);
//    [self.view addSubview:whiteImage];
    
   // myImage = [UIImage imageNamed:@"image11.png"];
//    _myImageView =[[UIImageView alloc] init];
//    _myImageView.frame = CGRectMake(0, rect1.size.height /2 -rect1.size.width /2, rect1.size.width, rect1.size.width);
//    NSLog(@"CGRect ->%f %f %f %f",rect1.origin.x, rect1.origin.y, rect1.size.width, rect1.size.height);
//
//    _myImageView.contentMode = UIViewContentModeScaleAspectFill;
//    [self.view addSubview:_myImageView];
    
    _myImageView.frame = CGRectMake(0, rect1.size.height / 2 - rect1.size.width / 2, rect1.size.width, rect1.size.height);
    _whiteImageView.frame = CGRectMake(0, rect1.size.height / 2 - rect1.size.width / 2, rect1.size.width, rect1.size.height);
    NSLog(@"UIImageViewのサイズは...%f", _myImageView.bounds.size.height);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (_camera != NULL){
        [_myImageView setImage:_camera.getImage];
        NSLog(@"aiueo");
    }
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






-(IBAction)CameraRoll:(id)sender{
    UIImagePickerController *imgpic = [[UIImagePickerController alloc] init];
    imgpic.delegate = self;
    [imgpic setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController: imgpic animated:YES completion:nil];
    
}


//カメラロール
-(void)imagePickerController:(UIImagePickerController *)imagePicker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *cameraImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    [_myImageView setImage:cameraImage];
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
    _myImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    
}


//-(void)imagePickerContyoller:(UIImagePickerController *)picker
//        didFinishPickerImage:(UIImage *)image editingInfon :(NSDictionary *)editingInfo {
//    [self.myImageView setImage:image];
//    [self dismissViewControllerAnimated:YES completion:nil];
//    _myImageView.contentMode = UIViewContentModeScaleAspectFill;
//}

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
    
    if (number<2) {
        _myImageView.frame = CGRectInset(_myImageView.bounds, 20, 20);
        _myImageView.center = CGPointMake( screen.size.width / 2,screen.size.height / 2);
        _myImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        number=number+1;
    }
    
    NSLog(@"%fsankaku",screen.origin.x, screen.origin.y, screen.size.width, screen.size.height);
}

-(IBAction)Save:(id)sender{
    
    CGRect screen = [[UIScreen mainScreen]bounds];
    CGRect saveImageView = CGRectMake(0,screen.size.height / 2 - screen.size.width / 2,screen.size.width,screen.size.width);
    
      //画質を良くした
    UIGraphicsBeginImageContextWithOptions(saveImageView.size, NO,0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGContextTranslateCTM(ctx, 0, -self->myImageView.frame.origin.y);
    
    CGContextSetFillColorWithColor(ctx, [[UIColor whiteColor] CGColor]);
    [[UIColor whiteColor] set];
    CGContextFillRect(ctx, saveImageView);
    
    //[self.myImageView.layer renderInContext:ctx];
    [self.whiteImageView.layer renderInContext:ctx];
    
    CGContextTranslateCTM(ctx, (self.whiteImageView.bounds.size.width - self.myImageView.bounds.size.width)/2 ,(self.whiteImageView.bounds.size.height - self.myImageView.bounds.size.height)/2 );
    [self.myImageView.layer renderInContext:ctx];
    
    UIImage *screenImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIActivityViewController *activityView = [[UIActivityViewController alloc] initWithActivityItems:@[screenImage]applicationActivities:@[] ];
    NSLog(@"screenImage:%f",screen.size.width, screen.size.height);
    
    [self presentViewController:activityView animated:YES completion:nil];
 
    
    
}







@end
