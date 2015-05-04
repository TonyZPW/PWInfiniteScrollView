//
//  PWQueue.h
//  PWInfiniteScrollView
//
//  Created by Tony_Zhao on 5/4/15.
//  Copyright (c) 2015 TonyZPW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PWQueue : NSObject
- (void)enqueue:(id)obj;
- (id)dequeue;
- (NSUInteger)count;
- (id)peak;
- (void)enqueueArray:(NSArray *)objs;
@end
