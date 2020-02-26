/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "AppDelegate.h"

#import <React/RCTBridge.h>
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
#import "samplemaps-Swift.h"
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

@interface PanManager : RCTEventEmitter <RCTBridgeModule>
@end
@implementation PanManager {
  RCTRootView* rootView;
}

//@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();

//- (instancetype)init
//{
//  self = [super init];
//  //  if (self) {
//  //      rootView = [[RCTRootView alloc] initWithBridge:self.bridge
//  //                                                     moduleName:@"appName2"
//  //                                              initialProperties:nil];
//  //  }
//  return self;
//}

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


RCT_EXPORT_METHOD(present)
{
  
  UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
  [rootViewController presentPanModalWithView:rootView];
  
}

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:launchOptions];
  RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge
                                                   moduleName:@"samplemaps"
                                            initialProperties:nil];
  
  
  
  rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
  
  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  UIViewController *rootViewController = [[UIViewController alloc] init];
  rootViewController.view = rootView;
  self.window.rootViewController = rootViewController;
  [self.window makeKeyAndVisible];
  return YES;
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
#else
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}

@end
