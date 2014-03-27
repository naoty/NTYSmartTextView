//
//  NTYWindowController.m
//  NTYSmartTextViewExample
//
//  Created by naoty on 2014/03/27.
//  Copyright (c) 2014年 Naoto Kaneko. All rights reserved.
//

#import "NTYWindowController.h"
#import "NTYSmartTextView.h"

@interface NTYWindowController ()
@property (nonatomic) IBOutlet NTYSmartTextView *textView;
@end

@implementation NTYWindowController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    self.textView.font = [NSFont fontWithName:@"Monaco" size:18];
}

@end
