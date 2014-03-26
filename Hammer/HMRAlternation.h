//  Copyright (c) 2014 Rob Rix. All rights reserved.

#import "HMRParserCombinator.h"

@interface HMRAlternation : HMRParserCombinator

+(instancetype)combinatorWithLeft:(id<HMRCombinator>)left right:(id<HMRCombinator>)right;

@property (readonly) id<HMRCombinator>left;
@property (readonly) id<HMRCombinator>right;


-(instancetype)init UNAVAILABLE_ATTRIBUTE;
+(instancetype)new UNAVAILABLE_ATTRIBUTE;

@end
