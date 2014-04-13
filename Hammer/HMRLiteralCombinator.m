//  Copyright (c) 2014 Rob Rix. All rights reserved.

#import "HMRLiteralCombinator.h"
#import "HMREmpty.h"

@implementation HMRLiteralCombinator

-(instancetype)initWithObject:(id<NSObject, NSCopying>)object {
	NSParameterAssert(object != nil);
	
	if ((self = [super init])) {
		_object = object;
	}
	return self;
}


#pragma mark HMRPredicateCombinator

-(bool)evaluateWithObject:(id)object {
	return
		self.object == object
	||	[self.object isEqual:object];
}


#pragma mark HMRTerminal

-(NSString *)describe {
	return [NSString stringWithFormat:@"'%@'", self.object];
}


#pragma mark NSObject

-(BOOL)isEqual:(HMRLiteralCombinator *)object {
	return
		[super isEqual:object]
	&&	[self.object isEqual:object.object];
}

@end


id<HMRCombinator> HMRLiteral(id<NSObject, NSCopying> object) {
	return [[HMRLiteralCombinator alloc] initWithObject:object];
}


REDPredicateBlock HMRLiteralPredicate(REDPredicateBlock object) {
	object = object ?: REDTruePredicateBlock;
	return [^ bool (HMRLiteralCombinator *combinator) {
		return
			[combinator isKindOfClass:[HMRLiteralCombinator class]]
		&&	object(combinator.object);
	} copy];
}
