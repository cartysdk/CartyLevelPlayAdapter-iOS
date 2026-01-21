
#import <Foundation/Foundation.h>
#import <IronSource/IronSource.h>

NS_ASSUME_NONNULL_BEGIN

@interface ISCartyCustomAdapter : ISBaseNetworkAdapter

+ (void)setGDPRStatus:(BOOL)bo;
+ (void)setDoNotSell:(BOOL)bo;
+ (void)setCOPPAStatus:(BOOL)bo;
+ (void)setLGPDStatus:(BOOL)bo;
@end

NS_ASSUME_NONNULL_END
