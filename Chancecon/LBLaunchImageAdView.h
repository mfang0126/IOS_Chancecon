//
//  LBLaunchImageAdView.h
//  LBLaunchImageAd

typedef enum {
    
    FullScreenAdType = 1,//全屏的广告
    LogoAdType = 0,//带logo的广告
    
}AdType;


#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

#define mainHeight      [[UIScreen mainScreen] bounds].size.height
#define mainWidth       [[UIScreen mainScreen] bounds].size.width

typedef void (^LBClick) (NSInteger tag);
@interface LBLaunchImageAdView : UIView

@property (strong, nonatomic) UIImageView *aDImgView;
@property (strong, nonatomic) UIWindow *window;
@property (assign, nonatomic) NSInteger adTime; //倒计时总时长,默认3秒
@property (strong, nonatomic) UIButton *skipBtn;
@property (nonatomic, copy)LBClick clickBlock;

- (instancetype)initWithWindow:(UIWindow *)window andType:(NSInteger)type andImgUrl:(NSString *)url;

@end
