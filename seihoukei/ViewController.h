//
//  ViewController.h
//  seihoukei
//
//  Created by TomokoTakahashi on 2015/10/14.
//  Copyright (c) 2015年 高橋知子. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraManager.h"


@interface ViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationBarDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UIImageView *whiteImageView;
@property (weak, nonatomic) UIImage *takenImage;
@property (weak, nonatomic) CameraManager *camera;
-(IBAction)Camera:(id)sender;
-(IBAction)CameraRoll:(id)sender;
-(IBAction)Seihoukei:(id)sender;
-(IBAction)Fill:(id)sender;
-(IBAction)Sankaku:(id)sender;
-(IBAction)Save:(id)sender;



@end

