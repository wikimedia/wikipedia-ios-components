//
//  WKSourceEditorTextStorage.h
//  
//
//  Created by Toni Sevener on 4/5/23.
//

#import <UIKit/UIKit.h>
@class WKSourceEditorFormatter, WKSourceEditorTextStorageColors, WKSourceEditorTextStorageFonts;

NS_ASSUME_NONNULL_BEGIN

@interface WKSourceEditorTextStorage : NSTextStorage

- (void)addFormatter:(WKSourceEditorFormatter *)formatter;
- (void)updateColors:(WKSourceEditorTextStorageColors *)colors;
- (void)updateFonts:(WKSourceEditorTextStorageFonts *)fonts;
@end

NS_ASSUME_NONNULL_END
