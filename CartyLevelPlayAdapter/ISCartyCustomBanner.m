
#import "ISCartyCustomBanner.h"
#import <CartySDK/CartySDK.h>

@interface ISCartyCustomBanner()<CTBannerAdDelegate>

@property (nonatomic,weak)id<ISBannerAdDelegate> delegate;
@property (nonatomic,strong)CTBannerAd *bannerAd;
@end

@implementation ISCartyCustomBanner

- (void)loadAdWithAdData:(nonnull ISAdData *)adData
          viewController:(nonnull UIViewController *)viewController
                    size:(nonnull ISBannerSize *)size
                delegate:(nonnull id<ISBannerAdDelegate>)delegate
{
    NSString *pid = adData.configuration[@"pid"];
    if(pid == nil)
    {
        [delegate adDidFailToLoadWithErrorType:ISAdapterErrorTypeInternal errorCode:401 errorMessage:@"no pid"];
        return;
    }
    self.delegate = delegate;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.bannerAd = [[CTBannerAd alloc] init];
        self.bannerAd.placementid = pid;
        self.bannerAd.delegate = self;
        self.bannerAd.bannerSize = [self getBannerSize:size];
        self.bannerAd.frame = CGRectMake(0, 0, size.width,size.height);
        [self.bannerAd loadAd];
    });
}

- (CTBannerSizeType)getBannerSize:(ISBannerSize *)size
{
    if([size.sizeDescription isEqualToString:kSizeBanner])
    {
        return CTBannerSizeType320x50;
    }
    else if ([size.sizeDescription isEqualToString:kSizeRectangle])
    {
        return CTBannerSizeType300x250;
    }
    else if([size.sizeDescription isEqualToString:kSizeLarge])
    {
        return CTBannerSizeType320x100;
    }
    return CTBannerSizeType300x250;
}

- (void)destroyAdWithAdData:(nonnull ISAdData *)adData
{
    if(self.bannerAd)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.bannerAd.delegate = nil;
            [self.bannerAd removeFromSuperview];
            self.bannerAd = nil;
        });
    }
}

- (BOOL)isSupportAdaptiveBanner
{
    return NO;
}

- (void)CTBannerAdDidLoad:(nonnull CTBannerAd *)ad
{
    [self.delegate adDidLoadWithView:self.bannerAd];
}

- (void)CTBannerAdLoadFail:(nonnull CTBannerAd *)ad withError:(nonnull NSError *)error
{
    [self.delegate adDidFailToLoadWithErrorType:ISAdapterErrorTypeNoFill errorCode:error.code errorMessage:error.localizedDescription];
}

- (void)CTBannerAdDidShow:(nonnull CTBannerAd *)ad
{
    [self.delegate adDidOpen];
}

- (void)CTBannerAdShowFail:(nonnull CTBannerAd *)ad withError:(nonnull NSError *)error
{
    [self.delegate adDidFailToShowWithErrorCode:error.code errorMessage:error.localizedDescription];
}

- (void)CTBannerAdDidClick:(nonnull CTBannerAd *)ad
{
    [self.delegate adDidClick];
}

- (void)CTBannerAdDidClose:(nonnull CTBannerAd *)ad
{
    
}
@end
