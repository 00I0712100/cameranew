//
//  ViewController.h
//  seihoukei
//
//  Created by TomokoTakahashi on 2015/10/14.
//  Copyright (c) 2015年 高橋知子. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationBarDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;

-(IBAction)Camera:(id)sender;
-(IBAction)CameraRoll:(id)sender;
-(IBAction)Seihoukei:(id)sender;
-(IBAction)Fill:(id)sender;
-(IBAction)Sankaku:(id)sender;
-(IBAction)Save:(id)sender;


@end

