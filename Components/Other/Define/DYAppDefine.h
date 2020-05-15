
/*--------------------------------开发中常用到的宏定义--------------------------------------*/

#define DYPinyinSeperator @"#"

#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)  

// 调试模式下输入NSLog，发布后不再输入。
#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif

#define DYLogFunc NSLog(@"%s",__func__);

//----------页面设计相关-------
#define KNavBarHeight         44
#define KTabBarHeight         49
#define KSatuesHeight         20
#define KScreenWidth          ([UIScreen mainScreen].bounds.size.width)
#define KScreenHeight         ([UIScreen mainScreen].bounds.size.height)

// 系统目录
#define kDocuments  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define KUserDefaults       [NSUserDefaults standardUserDefaults]
#define KNotificationCenter [NSNotificationCenter defaultCenter]
#define iOSVersion [[[UIDevice currentDevice] systemVersion] floatValue]

//APP导航栏背景颜色
#define AppNavBarColor  [UIColor colorWithRed:75/255.0 green:152/255.0 blue:230/255.0 alpha:1.0]

/// enmu
#define integerToNumber(x) [NSNumber numberWithInteger:x]

/// 蓝色
#define UM_BARCOLR_BLUE KHexToColor(@"0e88eb")
/// 白色
#define UM_BARCOLR_WHITE KHexToColor(@"f7f7f7")
/// 浅灰色，用户下划线，极淡
#define UM_BARCOLR_LIGHTGREY [UIColor colorFromHexRGB:@"EFEFEF"]
/// 下划线颜色
#define UM_BARCOLR_UNDERLIN [UIColor colorFromHexRGB:@"EDEDED"]

// 判断设备类型
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size)) : NO)

// 判断设备类型
#define IS_IPHONEX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size)) : NO)

#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)

//判断是iPhonex刘海屏
#define IS_IPhoneXAll ([UIScreen mainScreen].bounds.size.height == 812 || [UIScreen mainScreen].bounds.size.height == 896)

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define scaleX                [UIScreen mainScreen].bounds.size.width/375
#define scaleY                (iPhoneX ? (667.0/672) : ([UIScreen mainScreen].bounds.size.height/672))

#define Scale_X(a)            (a*scaleX)
#define Scale_Y(a)            (a*scaleY)

#define RECT(a,b,c,d,e)       CGRectMake(a * scaleX, e==0 ? b:b*scaleY, c * scaleX, d*scaleY)

//#define kWJHeightCoefficient (kWJScreenHeight == 812.0 ? 667.0/667.0 : kWJScreenHeight/667.0)

/// 顶部角的适配
#define SafeAreaTopHeight (IS_IPhoneXAll == YES ? 88 : 64)

/// 底部角的适配
#define SafeAreaBottomTabHeight (IS_IPhoneXAll == YES ? (34+49) : 49)

/// 底部安全域高度
#define SafeAreaBottomHeightConst (IS_IPhoneXAll ? 34 : 0)

/// 顶部安全域高度
#define SafeAreaTopHeightConst (IS_IPhoneXAll ? 24 : 0)


/// 字符串为空去（null）
#define noNull(str) (str==nil?@"":str)
/// 字符串转integer 若等于0，返回nil
#define no0toNil(str) (str.integerValue == 0?nil:str)

/// NSInteger转NSString
#define integerToString(intgerValue) [NSString stringWithFormat:@"%ld",intgerValue]

//#define noNull(str) ([str isKindOfClass:[NSNull class]]?@"":str)

#pragma mark -  字体系数
// 设置（方正黑体简体字体）字体大小
#define FontScale (IS_IPAD? 1 : scaleX)

#define kFONT(F)  [UIFont systemFontOfSize:(F*FontScale)]

#define kFONTWithBlod(size) [UIFont boldSystemFontOfSize:size];

#define kBoldFONT(size,weight) [UIFont systemFontOfSize:size weight:weight]

//获取图片资源
#define kSetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

//---------系统版本--------
#define iOS6 iOSVersion=6.0
#define iOS7 iOSVersion>=7.0
#define iOS8 iOSVersion>=8.0
#define iOS9 iOSVersion>=9.0
#define iOS10 iOSVersion>=10.0

//----------常用颜色-------
#define KColor(r,g,b,a)   [UIColor colorWithRed:r/255.0\
                                          green:g/255.0\
                                           blue:b/255.0 alpha:a]
#define KRandomColor    [UIColor colorWithHue:arc4random_uniform(255)/255.0\
                                   saturation:arc4random_uniform(255)/255.0\
                                   brightness:arc4random_uniform(255)/255.0 alpha:1]
// rgb颜色转换（16进制->10进制）
#define KHexToColor(Hex) [UIColor colorFromHexRGB:Hex]

// 添加监听
#define KAddNotificationCenter(method,NotiName) [[NSNotificationCenter defaultCenter] addObserver:self\
                                                                                         selector:@selector(method:)\
                                                                                             name:NotiName\
                                                                                           object:nil];
// 移除监听
#define KRemoveNotificationCenter(NotiName)  [[NSNotificationCenter defaultCenter] removeObserver:self\
                                                                                             name:NotiName\
                                                                                           object:nil];

#define MESSAGEBOX(msg)\
{\
UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:msg preferredStyle:UIAlertControllerStyleAlert];\
UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {\
}];\
[alert addAction:action];\
[[[[UIApplication sharedApplication] delegate] window].rootViewController presentViewController:alert animated:YES completion:nil];\
}


// 避免宏循环引用
#ifndef LLWeakObj
#if DEBUG
#if __has_feature(objc_arc)
#define LLWeakObj(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define LLWeakObj(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define LLWeakObj(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define LLWeakObj(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef LLStrongObj
#if DEBUG
#if __has_feature(objc_arc)
#define LLStrongObj(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define LLStrongObj(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define LLStrongObj(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define LLStrongObj(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif
