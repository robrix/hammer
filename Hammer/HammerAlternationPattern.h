//  HammerAlternationPattern.h
//  Created by Rob Rix on 12-06-26.
//  Copyright (c) 2012 Monochrome Industries. All rights reserved.

#import <Hammer/HammerDerivativePattern.h>

@interface HammerAlternationPattern : NSObject <HammerDerivativePattern>

+(id<HammerDerivativePattern>)patternWithLeftPattern:(id<HammerDerivativePattern>)left rightPattern:(id<HammerDerivativePattern>)right;

@end
