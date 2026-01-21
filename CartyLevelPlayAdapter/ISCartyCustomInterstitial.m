
#import "ISCartyCustomInterstitial.h"
#import <CartySDK/CartySDK.h>

@interface ISCartyCustomInterstitial()<CTInterstitialAdDelegate>

@property (nonatomic,strong) CTInterstitialAd *interstitialAd;
@property (nonatomic, weak) id<ISInterstitialAdDelegate> delegate;
@end

@implementation ISCartyCustomInterstitial

- (void)loadAdWithAdData:(nonnull ISAdData *)adData delegate:(nonnull id<ISInterstitialAdDelegate>)delegate
{
    NSString *pid = adData.configuration[@"pid"];
    if(pid == nil)
    {
        [delegate adDidFailToLoadWithErrorType:ISAdapterErrorTypeInternal errorCode:401 errorMessage:@"no pid"];
        return;
    }
    self.delegate = delegate;
    self.interstitialAd = [[CTInterstitialAd alloc] init];
    self.interstitialAd.placementid = pid;
    self.interstitialAd.delegate = self;
    [self.interstitialAd loadAd];
}

- (BOOL)isAdAvailableWithAdData:(nonnull ISAdData *)adData
{
    if(self.interstitialAd)
    {
        return self.interstitialAd.isReady;
    }
    return false;
}

- (void)showAdWithViewController:(nonnull UIViewController *)viewController adData:(nonnull ISAdData *)adData delegate:(nonnull id<ISInterstitialAdDelegate>)delegate
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.interstitialAd showAd:viewController];
    });
}


- (void)CTInterstitialAdDidLoad:(nonnull CTInterstitialAd *)ad
{
    [self.delegate adDidLoad];
}

- (void)CTInterstitialAdLoadFail:(nonnull CTInterstitialAd *)ad withError:(nonnull NSError *)error
{
    [self.delegate adDidFailToLoadWithErrorType:ISAdapterErrorTypeNoFill errorCode:error.code errorMessage:error.localizedDescription];
}

- (void)CTInterstitialAdDidShow:(nonnull CTInterstitialAd *)ad
{
    [self.delegate adDidOpen];
}

- (void)CTInterstitialAdShowFail:(nonnull CTInterstitialAd *)ad withError:(nonnull NSError *)error
{
    [self.delegate adDidFailToShowWithErrorCode:error.code errorMessage:error.localizedDescription];
}

- (void)CTInterstitialAdDidClick:(nonnull CTInterstitialAd *)ad
{
    [self.delegate adDidClick];
}

- (void)CTInterstitialAdDidDismiss:(nonnull CTInterstitialAd *)ad
{
    [self.delegate adDidClose];
}

@end
