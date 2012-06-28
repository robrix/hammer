//  HammerBlankPattern.m
//  Created by Rob Rix on 12-06-27.
//  Copyright (c) 2012 Monochrome Industries. All rights reserved.

#import "HammerBlankPattern.h"
#import "HammerNullPattern.h"

@implementation HammerBlankPattern

+(HammerBlankPattern *)pattern {
	static HammerBlankPattern *pattern = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		pattern = [self new];
	});
	return pattern;
}


-(BOOL)match:(id)object {
	return object == nil;
}

-(id<HammerDerivativePattern>)delta {
	return self;
}

-(id<HammerDerivativePattern>)derivativeWithRespectTo:(id)object {
	return [HammerNullPattern pattern];
}


-(BOOL)isNull {
	return NO;
}

-(BOOL)isEmpty {
	return YES;
}


-(BOOL)isEqual:(id)object {
	return [object isKindOfClass:self.class];
}


-(id)copyWithZone:(NSZone *)zone {
	return self;
}

@end
