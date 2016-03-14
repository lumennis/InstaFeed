
#ifndef Macros_h
#define Macros_h

//APP INFO
#pragma mark - APP INFO

static inline NSString* AppName() {

    NSDictionary *infoDict = [[NSBundle mainBundle]infoDictionary];
    NSString *appName = infoDict[@"CFBundleDisplayName"];
    if(!appName)
        appName = infoDict[@"CFBundleName"];

    return appName;
}

static inline NSString* AppVersion() {
    
    NSDictionary *infoDict = [[NSBundle mainBundle]infoDictionary];
    NSString *appVersion = infoDict[@"CFBundleShortVersionString"];

    if(!appVersion || ![appVersion isKindOfClass:[NSString class]])
        appVersion = @"";
        
    return appVersion;
}

static inline NSString* AppIdentifier() {
    
    NSString *appID = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    return appID;
}


//CGRect
#pragma mark - CGRect

#define CGRectByChangingHeight(rect, height) CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, height)
#define CGRectByChangingWidth(rect, width) CGRectMake(rect.origin.x, rect.origin.y, width, rect.size.height)
#define CGRectByChangingOriginX(rect, x) CGRectMake(x, rect.origin.y, rect.size.width, rect.size.height)
#define CGRectByChangingOriginY(rect, y) CGRectMake(rect.origin.x, y, rect.size.width, rect.size.height)
#define CGRectByChangingOrigin(rect, x, y) CGRectMake(x, y, rect.size.width, rect.size.height)
#define CGRectByChangingSize(rect, width, height) CGRectMake(rect.origin.x, rect.origin.y, width, height)

//SCREEN
#pragma mark - SCREEN

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)
#define IS_LANDSCAPE UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_3_5_INCH (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_4_INCH (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_4_7_INCH (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
//#define IS_5_INCH (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

static inline BOOL iPhone6PlusDevice() {
    if ([UIScreen mainScreen].scale > 2.9) return YES;   // Scale is only 3 when not in scaled mode for iPhone 6 Plus
    return NO;
}

static inline BOOL iPhone6PlusUnZoomed() {
    if (iPhone6PlusDevice()){
        if ([UIScreen mainScreen].bounds.size.height > 720.0) return YES;  // Height is 736, but 667 when zoomed.
    }
    return NO;
}

#define IS_5_INCH (IS_IPHONE && iPhone6PlusDevice())


//IOS VERSION
#pragma mark - IOS VERSION

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//PATHS
#pragma mark - PATHS

#define DOCUMENTS_FOLDER_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

//COLORS
#pragma mark - COLORS

#define UIColorFromRGBWithAlpha(rgbValue, al) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:al]
#define UIColorFromRGB(rgbValue) UIColorFromRGBWithAlpha(rgbValue, 1.0)

//LOGS
#pragma mark - LOGS

#if DEBUG || DEBUG_LOGS

#include <string.h>
#define FILE_NM (strrchr(__FILE__, '/') ? strrchr(__FILE__, '/') + 1 : __FILE__)
#define NSLog(fmt, ...) NSLog((@"[File - %s] [Line - %d] " fmt), FILE_NM, __LINE__, ##__VA_ARGS__)

#endif

#if STAGING || DEBUG_LOGS
#define DLog(s, ...) NSLog(s, ##__VA_ARGS__)
#else
#define DLog(s, ...)
#endif

#define IS_GOOGLE_MAPS_INSTALLED [[UIApplication sharedApplication] canOpenURL: [NSURL URLWithString:@"comgooglemaps://"]]


#endif
