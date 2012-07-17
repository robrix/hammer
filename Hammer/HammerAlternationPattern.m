//  HammerAlternationPattern.m
//  Created by Rob Rix on 12-06-26.
//  Copyright (c) 2012 Monochrome Industries. All rights reserved.

#import "HammerAlternationPattern.h"
#import "HammerDerivativePattern.h"
#import "HammerEpsilonPattern.h"
#import "HammerList.h"


@interface HammerAlternationPattern () <HammerVisitable>
@end

@implementation HammerAlternationPattern {
	id<HammerDerivativePattern> _left;
	id<HammerDerivativePattern> _right;
	HammerLazyPattern _lazyLeft;
	HammerLazyPattern _lazyRight;
}

+(id<HammerPattern>)patternWithPatterns:(NSArray *)patterns {
	HammerLazyPattern lazy = HammerArrayToList(patterns, 0, ^{
		return (id)HammerDelayPattern([HammerEpsilonPattern pattern]);
	}, ^(id (^pattern)()) {
		return (id)pattern;
	}, ^(id (^left)(), id (^right)()) {
		return (id)HammerDelayPattern([self patternWithLeftPattern:left rightPattern:right]);
	});
	return lazy();
}

+(id<HammerPattern>)patternWithLeftPattern:(HammerLazyPattern)left rightPattern:(HammerLazyPattern)right {
	HammerAlternationPattern *pattern = [self new];
	pattern->_lazyLeft = left;
	pattern->_lazyRight = right;
	return pattern;
}


-(id<HammerDerivativePattern>)left {
	return _left ?: (_left = HammerDerivativePattern(_lazyLeft()));
}

-(id<HammerDerivativePattern>)right {
	return _right ?: (_right = HammerDerivativePattern(_lazyRight()));
}


//-(void)updateRecursiveAttributes:(HammerChangeCell *)change {
//	[self.left updateRecursiveAttributes:change];
//	[self.right updateRecursiveAttributes:change];
//}


-(BOOL)isNullable {
	return !self.isNull && (self.left.isNullable || self.right.isNullable);
}

-(BOOL)isNull {
	return self.left.isNull && self.right.isNull;
}


-(id<HammerPattern>)derivativeWithRespectTo:(id)object {
	if (self.left.isNull)
		return [self.right derivativeWithRespectTo:object];
	else if (self.right.isNull)
		return [self.left derivativeWithRespectTo:object];
	else
		return [HammerAlternationPattern patternWithLeftPattern:HammerDelayPattern([self.left derivativeWithRespectTo:object]) rightPattern:HammerDelayPattern([self.right derivativeWithRespectTo:object])];
}


-(id)acceptVisitor:(id<HammerVisitor>)visitor {
	id childrenResults = nil;
	if ([visitor visitObject:self])  {
		id leftResult = [self.left acceptVisitor:visitor];
		id rightResult = [self.right acceptVisitor:visitor];
		childrenResults = (leftResult || rightResult)?
			[NSArray arrayWithObjects:leftResult, rightResult, nil]
		:	[NSArray array];
	}
	return [visitor leaveObject:self withVisitedChildren:childrenResults];
}


-(BOOL)isEqualToAlternationPattern:(HammerAlternationPattern *)other {
	return
		[other isKindOfClass:self.class]
	&&	[self.left isEqual:other.left]
	&&	[self.right isEqual:other.right];
}

-(BOOL)isEqual:(id)object {
	return [self isEqualToAlternationPattern:object];
}


-(id)copyWithZone:(NSZone *)zone {
	return self;
}

@end
