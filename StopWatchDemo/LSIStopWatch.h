//
//  LSIStopWatch.h
//  StopWatchDemo
//
//  Created by Dongwoo Pae on 11/15/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIStopWatch : NSObject

-(void)start;
-(void)stop;
-(void)reset;

@property (nonatomic, readonly, getter=isRunning) BOOL running;
@property (nonatomic, readonly) NSTimeInterval elapsedTime; //double

@end

NS_ASSUME_NONNULL_END
