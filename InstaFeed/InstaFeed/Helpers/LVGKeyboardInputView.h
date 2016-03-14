//
//  KeyboardInputView.h
//


#import <UIKit/UIKit.h>

@interface LVGKeyboardInputView : UIView

@property (nonatomic, weak) UIView * activeInputView;
@property (nonatomic, strong) NSMutableArray *inputItems;
@property (nonatomic, assign) CGFloat scrollViewOriginContentHeight;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (strong, nonatomic, readonly) UIToolbar *toolbar;

@property (nonatomic, strong) void(^doneActionBlock)();

- (void)updateKeyboardInputBtns;

- (void) endEditing;
- (void) updateOffset;

@end
