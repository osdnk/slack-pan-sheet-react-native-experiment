//
//  PanModule.m
//  samplemaps
//
//  Created by Michał Osadnik on 26/02/2020.
//  Copyright © 2020 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>
#import <React/RCTBridge.h>
#import <React/RCTRootView.h>
#import "samplemaps-Swift.h"

@interface PanManager : RCTEventEmitter <RCTBridgeModule>
@end
@implementation PanManager {
  RCTRootView* rootView;
}

RCT_EXPORT_MODULE();


- (NSArray<NSString *> *)supportedEvents {
  return @[];
}

- (void)setBridge:(RCTBridge *)bridge {
  [super setBridge:bridge];
  rootView = [[RCTRootView alloc] initWithBridge:bridge
                                      moduleName:@"appName2"
                               initialProperties:nil];
  
}

+ (BOOL)requiresMainQueueSetup
{
  return YES;
}

- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}


RCT_EXPORT_METHOD(present:(NSDictionary<NSString *, id> *)config)
{
  
  UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
  [rootViewController presentPanModalWithView:rootView config:config];
}

@end
