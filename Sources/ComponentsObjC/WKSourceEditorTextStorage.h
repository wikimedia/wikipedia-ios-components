//
//  WKSourceEditorTextStorage.h
//  
//
//  Created by Toni Sevener on 4/5/23.
//

#import <UIKit/UIKit.h>
@class WKSourceEditorFormatter, WKSourceEditorTextStorageColors, WKSourceEditorTextStorageFonts, WKSourceEditorFormatterBoldItalics;

NS_ASSUME_NONNULL_BEGIN

@interface WKSourceEditorTextStorage : NSTextStorage

@property (nonatomic, strong, readonly) WKSourceEditorFormatterBoldItalics *boldItalicsFormatter;

- (instancetype)initWithColors:(nonnull WKSourceEditorTextStorageColors *)colors fonts:(nonnull WKSourceEditorTextStorageFonts *)fonts;

- (void)updateColors:(WKSourceEditorTextStorageColors *)colors andFonts:(WKSourceEditorTextStorageFonts *)fonts;

- (BOOL)isBoldInRange:(NSRange)range;
- (BOOL)isItalicsInRange:(NSRange)range;
@end

NS_ASSUME_NONNULL_END
