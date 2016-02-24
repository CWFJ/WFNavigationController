//
//  WFHookTool.m
//  WFHookTest
//
//  Created by Jason on 15/12/30.
//  Copyright © 2015年 raydun. All rights reserved.
//

#import "WFHookTool.h"
#import <objc/runtime.h>

void exchangeInstanceMethod(Class aClass, SEL oldSEL, SEL newSEL)
{
    Method oldMethod = class_getInstanceMethod(aClass, oldSEL);
    assert(oldMethod);
    Method newMethod = class_getInstanceMethod(aClass, newSEL);
    assert(newMethod);
    method_exchangeImplementations(oldMethod, newMethod);
}

void exchangeClassMethod(Class aClass, SEL oldSEL, SEL newSEL)
{
    Method oldMethod = class_getClassMethod(aClass, oldSEL);
    assert(oldMethod);
    Method newMethod = class_getClassMethod(aClass, newSEL);
    assert(newMethod);
    method_exchangeImplementations(oldMethod, newMethod);
}

@implementation WFHookTool

#pragma mark ------<Hook实例方法>
/**
 *  Hook实例方法
 *
 *  @param dstSEL    hook目标SEL
 *  @param dstClass  hook目标Class
 *  @param hookClass hook的Class
 *  @param hookSEL   hook的SEL
 *  @note  使用hookClass的hookSEL方法 HOOK 到 dstClass的dstSEL方法
 */
+ (void)hookInstanceSEL:(SEL)dstSEL dstClass:(Class)dstClass hookSEL:(SEL)hookSEL hookClass:(Class)hookClass
{
    const char *types = method_getTypeEncoding(class_getInstanceMethod(dstClass, dstSEL));
    if(types == NULL) {
        const char *type = method_getTypeEncoding(class_getInstanceMethod(hookClass, hookSEL));
        class_addMethod(dstClass, dstSEL, class_getMethodImplementation(hookClass, hookSEL), type);
        return;
    }
    
    class_addMethod(dstClass, hookSEL, class_getMethodImplementation(hookClass, hookSEL), types);
    // 交换实现
    exchangeInstanceMethod(dstClass, dstSEL, hookSEL);
}

//#pragma mark ------<Hook类方法>
///**
// *  Hook类方法
// *
// *  @param dstSEL    hook目标SEL
// *  @param dstClass  hook目标Class
// *  @param hookClass hook的Class
// *  @param hookSEL   hook的SEL
// *  @note  使用hookClass的hookSEL方法 HOOK 到 dstClass的dstSEL方法
// */
//+ (void)hookClassSEL:(SEL)dstSEL dstClass:(Class)dstClass hookSEL:(SEL)hookSEL hookClass:(Class)hookClass
//{
//    const char *types = method_getTypeEncoding(class_getClassMethod(dstClass, dstSEL));
//    /** !!!无法增加类方法 */
//    class_addMethod(dstClass, hookSEL, method_getImplementation(class_getClassMethod(hookClass, hookSEL)), types);
//    // 交换实现
//    exchangeClassMethod(dstClass, dstSEL, hookSEL);
//}
@end
