//
//  PWQueue.m
//  PWInfiniteScrollView
//
//  Created by Tony_Zhao on 5/4/15.
//  Copyright (c) 2015 TonyZPW. All rights reserved.
//

#import "PWQueue.h"

@interface PWQueue()

@property (nonatomic, strong) NSMutableArray *queue;
@end

@implementation PWQueue

- (instancetype)init
{
    if(self = [super init]){
        
        self.queue = [NSMutableArray array];
    }
    
    return self;
}

- (void)enqueue:(id)obj
{
    [self.queue addObject:obj];
}
-(NSUInteger)count {
    return [self.queue count];
}

- (id)dequeue
{
    id item = nil;
    if([self count] != 0){
        item = [self.queue objectAtIndex:0];
        [self.queue removeObjectAtIndex:0];
    }
    return item;
}

- (id)peak{
    id item = nil;
    if([self count] != 0){
        item = [self.queue objectAtIndex:0];
    }
    return item;
}

- (void)enqueueArray:(NSArray *)objs{
    
    for (id item in objs) {
        [self enqueue:item];
    }
}

@end
