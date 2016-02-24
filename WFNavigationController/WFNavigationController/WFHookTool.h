//
//  WFHookTool.h
//  WFHookTest
//
//  Created by Jason on 15/12/30.
//  Copyright © 2015年 raydun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface WFHookTool : NSObject
#pragma mark ------<Hook实例方法>
/**
 *  Hook实例方法
 *
 *  @param dstSEL    hook目标SEL
 *  @param dstClass  hook目标Class
 *  @param hookSEL   hook的SEL
 *  @param hookClass hook的Class
 *  @note  使用hookClass的hookSEL方法 HOOK 到 dstClass的dstSEL方法
 */
+ (void)hookInstanceSEL:(SEL)dstSEL dstClass:(Class)dstClass hookSEL:(SEL)hookSEL hookClass:(Class)hookClass;

//#pragma mark ------<Hook类方法>
///**
// *  Hook类方法
// *
// *  @param dstSEL    hook目标SEL
// *  @param dstClass  hook目标Class
// *  @param hookSEL   hook的SEL
// *  @param hookClass hook的Class
// *  @note  使用hookClass的hookSEL方法 HOOK 到 dstClass的dstSEL方法
// */
//+ (void)hookClassSEL:(SEL)dstSEL dstClass:(Class)dstClass hookSEL:(SEL)hookSEL hookClass:(Class)hookClass;
@end
