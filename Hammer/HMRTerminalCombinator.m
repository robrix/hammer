//  Copyright (c) 2014 Rob Rix. All rights reserved.

#import "HMRTerminalCombinator.h"

@implementation HMRTerminalCombinator

#pragma mark HMRCombinator

-(id<HMRCombinator>)derivative:(id<NSObject,NSCopying>)object {
	return self;
}


-(bool)isNullable {
	return NO;
}

-(bool)isCyclic {
	return NO;
}


-(NSSet *)parseForest {
	return [NSSet set];
}


-(instancetype)compaction {
	return self;
}


@dynamic description;


@synthesize name = _name;

-(instancetype)withName:(NSString *)name {
	_name = name;
	return self;
}


#pragma mark NSCopying

-(instancetype)copyWithZone:(NSZone *)zone {
	return self;
}


#pragma mark NSObject

-(BOOL)isEqual:(id)object {
	return [object isKindOfClass:self.class];
}

@end
