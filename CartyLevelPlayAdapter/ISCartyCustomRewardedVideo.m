
#import "ISCartyCustomRewardedVideo.h"
#import <CartySDK/CartySDK.h>

@interface ISCartyCustomRewardedVideo()<CTRewardedVideoAdDelegate>

@property (nonatomic,strong)CTRewardedVideoAd *rewardedVideoAd;
@property (nonatomic, weak) id<ISRewardedVideoAdDelegate> delegate;
@end

@implementation ISCartyCustomRewardedVideo

- (void)loadAdWithAdData:(ISAdData *)adData delegate:(id<ISRewardedVideoAdDelegate>)delegate
{
    NSString *pid = adData.configuration[@"pid"];
    if(pid == nil)
    {
        [delegate adDidFailToLoadWithErrorType:ISAdapterErrorTypeInternal errorCode:401 errorMessage:@"no pid"];
        return;
    }
    self.delegate = delegate;
    self.rewardedVideoAd = [[CTRewardedVideoAd alloc] init];
    self.rewardedVideoAd.placementid = pid;
    self.rewardedVideoAd.delegate = self;
    [self.rewardedVideoAd loadAd];
}

- (BOOL)isAdAvailableWithAdData:(nonnull ISAdData *)adData
{
    if(self.rewardedVideoAd)
    {
        return self.rewardedVideoAd.isReady;
    }
    return false;
}

- (void)showAdWithViewController:(UIViewController *)viewController
                          adData:(ISAdData *)adData
                        delegate:(id<ISRewardedVideoAdDelegate>)delegate
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.rewardedVideoAd showAd:viewController];
    });
}


- (void)CTRewardedVideoAdDidLoad:(nonnull CTRewardedVideoAd *)ad
{
    [self.delegate adDidLoad];
}

- (void)CTRewardedVideoAdLoadFail:(nonnull CTRewardedVideoAd *)ad withError:(nonnull NSError *)error
{
    [self.delegate adDidFailToLoadWithErrorType:ISAdapterErrorTypeNoFill errorCode:error.code errorMessage:error.localizedDescription];
}

- (void)CTRewardedVideoAdDidShow:(nonnull CTRewardedVideoAd *)ad
{
    [self.delegate adDidOpen];
}

- (void)CTRewardedVideoAdShowFail:(nonnull CTRewardedVideoAd *)ad withError:(nonnull NSError *)error
{ 
    [self.delegate adDidFailToShowWithErrorCode:error.code errorMessage:error.localizedDescription];
}

- (void)CTRewardedVideoAdDidClick:(nonnull CTRewardedVideoAd *)ad
{
    [self.delegate adDidClick];
}

- (void)CTRewardedVideoAdDidDismiss:(nonnull CTRewardedVideoAd *)ad
{
    [self.delegate adDidClose];
}

- (void)CTRewardedVideoAdDidEarnReward:(nonnull CTRewardedVideoAd *)ad rewardInfo:(nonnull NSDictionary *)rewardInfo
{
    [self.delegate adRewardedWithExtraData:rewardInfo];
}

@end
