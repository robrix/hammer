//  Copyright (c) 2014 Rob Rix. All rights reserved.

#import "HMRLazyParser.h"
#import "HMRParser+Protected.h"

@implementation HMRLazyParser

+(instancetype)parserWithBlock:(HMRLazyParserBlock)block {
	return [[self alloc] initWithBlock:block];
}

-(instancetype)initWithBlock:(HMRLazyParserBlock)block {
	if ((self = [super init])) {
		_block = [block copy];
	}
	return self;
}


@synthesize parser = _parser;

-(HMRParser *)parser {
	return _parser ?: (_parser = self.block());
}


#pragma mark HMRParser

-(HMRParser *)derivativeWithRespectToElement:(id)element {
	return [self.parser derivativeWithRespectToElement:element];
}

@end