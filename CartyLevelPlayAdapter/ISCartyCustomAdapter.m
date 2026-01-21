
#import "ISCartyCustomAdapter.h"
#import <CartySDK/CartySDK.h>

@implementation ISCartyCustomAdapter

- (void)init:(ISAdData*)adData delegate:(id<ISNetworkInitializationDelegate>)delegate
{
    NSString *appid = adData.configuration[@"appid"];
    if(appid)
    {
        NSString *userID = adData.adUnitData[@"userId"];
        if(userID != nil)
        {
            [CartyADSDK sharedInstance].userid = userID;
        }
        [[CartyADSDK sharedInstance] start:appid completion:^{
            [delegate onInitDidSucceed];
        }];
    }
    else
    {
        [delegate onInitDidFailWithErrorCode:400 errorMessage:@"no appid"];
    }
}

- (void)setConsent:(BOOL)consent
{
    [[CartyADSDK sharedInstance] setGDPRStatus:consent];
}

- (NSString*)networkSDKVersion
{
    return [CartyADSDK sdkVersion];
}

- (NSString*)adapterVersion
{
    return @"1.0.0";
}

+ (void)setGDPRStatus:(BOOL)bo
{
    [[CartyADSDK sharedInstance] setGDPRStatus:bo];
}

+ (void)setDoNotSell:(BOOL)bo
{
    [[CartyADSDK sharedInstance] setDoNotSell:bo];
}

+ (void)setCOPPAStatus:(BOOL)bo
{
    [[CartyADSDK sharedInstance] setCOPPAStatus:bo];
}

+ (void)setLGPDStatus:(BOOL)bo
{
    [[CartyADSDK sharedInstance] setLGPDStatus:bo];
}
@end
