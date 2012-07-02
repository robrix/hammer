//  HammerBlockPattern.m
//  Created by Rob Rix on 12-06-25.
//  Copyright (c) 2012 Monochrome Industries. All rights reserved.

#import "HammerBlankPattern.h"
#import "HammerBlockPattern.h"
#import "HammerNullPattern.h"

@implementation HammerBlockPattern {
	HammerPatternBlock _block;
}

+(HammerBlockPattern *)patternWithBlock:(HammerPatternBlock)block {
	HammerBlockPattern *pattern = [self new];
	pattern->_block = [block copy];
	return pattern;
}


-(id<HammerDerivativePattern>)derivativeWithRespectTo:(id)object {
	return _block(object)?
		[HammerBlankPattern pattern]
	:	[HammerNullPattern pattern];
}


-(id)copyWithZone:(NSZone *)zone {
	return self;
}

@end
