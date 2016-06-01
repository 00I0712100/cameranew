//
//  CameraViewController.m
//  seihoukei
//
//  Created by TomokoTakahashi on 2015/12/09.
//  Copyright © 2015年 高橋知子. All rights reserved.
//

#import "CameraViewController.h"
#import "CameraManager.h"
#import "ViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
@import Photos;

@interface CameraViewController (){
    CameraManager *camera;
}

@property (weak,nonatomic) IBOutlet GPUImageView *cameraView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cameraButton2;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    camera = [CameraManager sharedManager];
    // s_imageView.frame = ;
    [camera startCamera:(GPUImageView *)self.cameraView];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.cameraView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill;
    
}
-(IBAction)performShutterButtonAction:(UIBarButtonItem *)sender
{
    [camera takePhoto];
    
   //画面遷移
    [self performSegueWithIdentifier:@"toViewController" sender:nil];
    //画像受け渡す
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Segueの特定
    if ( [[segue identifier] isEqualToString:@"toViewController"] ) {
        ViewController *viewController = [segue destinationViewController];
        //ここで遷移先ビューのクラスの変数receiveStringに値を渡している
        // PHAssetCollection を取得します
       /* PHAssetCollection * myAlbum = [self getMyAlbum];
        
        // PHAsset をフェッチします
        PHFetchResult *assets = [PHAsset fetchAssetsInAssetCollection:myAlbum options:nil];
        
        // フェッチ結果から assets を取り出します
        CGRect screen = [[UIScreen mainScreen]bounds];
        NSArray * assetArray = [self getAssets:assets];
        NSLog(@"asset num: %d",assetArray.count);
        typeof(self) __weak wself = self;
        [[PHImageManager defaultManager] requestImageForAsset:assetArray[assetArray.count-1]
                                                   targetSize:CGSizeMake(screen.size.width,screen.size.width)
                                                  contentMode:PHImageContentModeAspectFill
                                                      options:nil
                                                resultHandler:^(UIImage *result, NSDictionary *info) {
                                                    if (result) {
                                                        // imageVivew を更新します
                                                        viewController.myImageView.image = result;
                                                        NSLog(@"hallo");
                                                    }
                                                }];
       */
        viewController.camera = camera;
    }

}
- (PHAssetCollection *)getMyAlbum {
    // ユーザ作成のアルバム一覧を指定して、PHAssetCollection をフェッチします
    PHFetchResult *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum
                                                                               subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary
                                                                               options:nil];
    
    // [My Album]の AssetCollection を取得します
    __block PHAssetCollection * myAlbum;
    myAlbum = assetCollections.firstObject;
    return myAlbum;
}

- (NSArray *)getAssets:(PHFetchResult *)fetch {
    // フェッチ結果を配列に格納します
    __block NSMutableArray * assetArray = NSMutableArray.new;
    [fetch enumerateObjectsUsingBlock:^(PHAsset *asset, NSUInteger idx, BOOL *stop) {
        [assetArray addObject:asset];
    }];
    return assetArray;
}

-(IBAction)performSwitchCameraButtonAction:(UIButton *)sender
{
    [camera switchCameraPosition:self.cameraView];
    
}
-(IBAction)performPreviousButtonAction:(UIBarButtonItem *)sender
{
    [camera setPreviousFilter:self.cameraView];
}
-(IBAction)performNextButtonAction:(UIBarButtonItem *)sender
{
    //変える
    [camera setNextFilter:self.cameraView];
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
