//
//  WKSourceEditorFormatter.m
//  
//
//  Created by Toni Sevener on 5/1/23.
//

#import "WKSourceEditorFormatter.h"
#import "WKSourceEditorTextStorageColors.h"
#import "WKSourceEditorTextStorageFonts.h"

@implementation WKSourceEditorFormatter
- (void)applySyntaxHighlightingInString:(NSMutableAttributedString *)string toRange:(NSRange)range {
    // must override
}
@end
