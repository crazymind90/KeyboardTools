// By @CrazyMind90

#pragma GCC diagnostic ignored "-Wunused-variable"
#pragma GCC diagnostic ignored "-Wunused-but-set-variable"

 
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
 

@interface KeyboardTools : NSObject

@property UITextField *_self;

-(void) done;
-(void) copyText;
-(void) paste;
-(void) selectAll;
-(void) undo;
-(void) cut;
-(void) moveLeft;
-(void) moveRight;
- (UIBarButtonItem *) allocWithSystemImageNamed:(NSString *)imageName action:(SEL)action;
@end 

@implementation KeyboardTools

 
-(void) done {
  [self._self resignFirstResponder];
}

-(void) copyText {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    UITextRange *selectedRange = [self._self selectedTextRange];
    if (selectedRange && !selectedRange.isEmpty) {
        NSString *selectedText = [self._self textInRange:selectedRange];
        pasteboard.string = selectedText;
    }
}
 
-(void) paste {
  UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
  if (pasteboard.string.length > 0)
  self._self.text = [NSString stringWithFormat:@"%@%@",self._self.text.length > 0 ? self._self.text : @"",pasteboard.string];
}

-(void) selectAll {
  [self._self selectAll:self._self.text];
}

-(void) undo {
  [self._self.undoManager undo];
}

-(void) cut {
  [self._self cut:self._self.text];
}

-(void) moveLeft {
    UITextRange *selectedRange = [self._self selectedTextRange];
    if (selectedRange) {
        UITextPosition *newPosition = [self._self positionFromPosition:selectedRange.start inDirection:UITextLayoutDirectionLeft offset:1];
        if (newPosition) {
            self._self.selectedTextRange = [self._self textRangeFromPosition:newPosition toPosition:newPosition];
        }
    }
}

-(void) moveRight {
    UITextRange *selectedRange = [self._self selectedTextRange];
    if (selectedRange) {
        UITextPosition *newPosition = [self._self positionFromPosition:selectedRange.start inDirection:UITextLayoutDirectionRight offset:1];
        if (newPosition) {
            self._self.selectedTextRange = [self._self textRangeFromPosition:newPosition toPosition:newPosition];
        }
    }
}

- (UIBarButtonItem *) allocWithSystemImageNamed:(NSString *)imageName action:(SEL)action {
  return [[UIBarButtonItem alloc] initWithImage:[[UIImage systemImageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] style:UIBarButtonItemStylePlain target:self action:action];
}

@end


KeyboardTools *tools;
%hook UITextField
- (void)layoutSubviews {
 
   %orig;


if (![NSBundle.mainBundle.bundleIdentifier isEqual:@"com.tigisoftware.Filza"]) {

 
   UIToolbar *toolBar = [[UIToolbar alloc] init];

   [toolBar sizeToFit];

    if (!tools)
    tools = [KeyboardTools new];

    tools._self = self;


    UIBarButtonItem *done = [tools allocWithSystemImageNamed:@"checkmark.circle" action:@selector(done)];
    UIBarButtonItem *copy = [tools allocWithSystemImageNamed:@"doc.on.doc" action:@selector(copyText)];
    UIBarButtonItem *paste = [tools allocWithSystemImageNamed:@"doc.on.clipboard" action:@selector(paste)];
    UIBarButtonItem *cut = [tools allocWithSystemImageNamed:@"scissors" action:@selector(cut)];
    UIBarButtonItem *undo = [tools allocWithSystemImageNamed:@"arrow.uturn.backward" action:@selector(undo)];
    UIBarButtonItem *selectAll = [tools allocWithSystemImageNamed:@"selection.pin.in.out" action:@selector(selectAll)];
    UIBarButtonItem *moveLeft = [tools allocWithSystemImageNamed:@"arrow.left.circle" action:@selector(moveLeft)];
    UIBarButtonItem *moveRight = [tools allocWithSystemImageNamed:@"arrow.right.circle" action:@selector(moveRight)];


    UIColor *tintColor = [UIColor whiteColor];
    done.tintColor = tintColor;
    copy.tintColor = tintColor;
    paste.tintColor = tintColor;
    cut.tintColor = tintColor;
    undo.tintColor = tintColor;
    selectAll.tintColor = tintColor;
    moveLeft.tintColor = tintColor;
    moveRight.tintColor = tintColor;


    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

    toolBar.items = [NSArray arrayWithObjects:space, done, space, copy, space, paste, space, cut, space, undo, space, selectAll, space, moveLeft, space, moveRight, space, nil];

    self.inputAccessoryView = toolBar;
 
  }
 
}




%end
