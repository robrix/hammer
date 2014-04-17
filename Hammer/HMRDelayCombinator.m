//  Copyright (c) 2014 Rob Rix. All rights reserved.

#import "HMRCase.h"
#import "HMRDelayCombinator.h"
#import "HMRNonterminal.h"

@interface HMRDelayCombinator ()

@property (readonly) HMRCombinator *forced;

@end

@implementation HMRDelayCombinator

-(instancetype)initWithBlock:(HMRDelayBlock)block {
	return [super initWithClass:[HMRNonterminal class] block:block];
}


@dynamic forced;


#pragma mark HMRCombinator

-(HMRCombinator *)derivative:(id)object {
	return [self.forced derivative:object];
}


-(NSSet *)parseForest {
	return self.forced.parseForest;
}

l3_test(@selector(parseForest)) {
	NSSet *forest = [NSSet setWithObject:@"a"];
	HMRCombinator *capture = HMRCaptureForest(forest);
	HMRCombinator *delayed = HMRDelay(capture);
	l3_expect(HMRDelaySpecific([NSSet class], delayed.parseForest)).to.equal(forest);
	l3_expect(forest).to.equal(delayed.parseForest);
}


-(HMRCombinator *)compaction {
	return self.forcing? (HMRCombinator *)self : self.forced.compaction;
}


-(NSString *)name {
	return self.forced.name;
}

-(HMRCombinator *)withName:(NSString *)name {
	return (id)[(id)self.forced withName:name];
}


#pragma mark HMRPredicate

-(bool)matchObject:(id)object {
	return [self.forced matchObject:object];
}

-(id<HMRCase>)then:(id (^)())block {
	return [HMRCase caseWithPredicate:self.forced block:block];
}


#pragma mark REDReducible

-(id)red_reduce:(id)initial usingBlock:(REDReducingBlock)block {
	return [(id<REDReducible>)self.forced red_reduce:initial usingBlock:block];
}


#pragma mark Construction

-(HMRConcatenation *)and:(HMRCombinator *)other {
	return [HMRConcatenation concatenateFirst:(HMRCombinator *)self second:other];
}

-(HMRAlternation *)or:(HMRCombinator *)other {
	return HMROr((HMRCombinator *)self, other);
}

-(HMRReduction *)map:(HMRReductionBlock)block {
	return HMRMap((HMRCombinator *)self, block);
}

-(HMRRepetition *)repeat {
	return HMRRepeat((HMRCombinator *)self);
}

@end


HMRCombinator *HMRLazyCombinator(HMRCombinator *(^block)(void)) {
	return (id)[[HMRDelayCombinator alloc] initWithBlock:block];
}
