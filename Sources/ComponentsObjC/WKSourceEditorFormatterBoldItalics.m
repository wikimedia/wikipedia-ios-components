
#import "WKSourceEditorFormatterBoldItalics.h"
#import "WKSourceEditorTextStorageColors.h"
#import "WKSourceEditorTextStorageFonts.h"

@interface WKSourceEditorFormatterBoldItalics ()

@property (nonatomic, strong) NSDictionary *boldItalicsAttributes;
@property (nonatomic, strong) NSDictionary *boldAttributes;
@property (nonatomic, strong) NSDictionary *italicsAttributes;
@property (nonatomic, strong) NSDictionary *orangeAttributes;

@property (nonatomic, strong) NSDictionary *boldItalicsMarkingAttributes;
@property (nonatomic, strong) NSDictionary *boldMarkingAttributes;
@property (nonatomic, strong) NSDictionary *italicsMarkingAttributes;

@property (nonatomic, strong) NSRegularExpression *boldItalicsRegex;
@property (nonatomic, strong) NSRegularExpression *boldRegex;
@property (nonatomic, strong) NSRegularExpression *italicsRegex;

@end

@implementation WKSourceEditorFormatterBoldItalics

// Marking custom attributes help us determine when to set formatting button in a selected state
NSString *WKEditorAttributedStringKeyMarkingBoldItalics = @"WKEditorAttributedStringKeyMarkingBoldItalics";
NSString *WKEditorAttributedStringKeyMarkingBold = @"WKEditorAttributedStringKeyMarkingBold";
NSString *WKEditorAttributedStringKeyMarkingItalics = @"WKEditorAttributedStringKeyMarkingItalics";

// Font and Color custom attributes help us determine which ranges need to change upon theme and dynamic type size changes
NSString *WKEditorAttributedStringKeyFontBoldItalics = @"WKEditorAttributedStringKeyFontBoldItalics";
NSString *WKEditorAttributedStringKeyFontBold = @"WKEditorAttributedStringKeyFontBold";
NSString *WKEditorAttributedStringKeyFontItalics = @"WKEditorAttributedStringKeyFontItalics";
NSString *WKEditorAttributedStringKeyColorOrange = @"WKEditorAttributedStringKeyColorOrange";

- (instancetype)initWithColors:(nonnull WKSourceEditorTextStorageColors *)colors fonts:(nonnull WKSourceEditorTextStorageFonts *)fonts {
    self = [super initWithColors:colors fonts:fonts];
    if (self) {

        _boldItalicsMarkingAttributes = @{
            WKEditorAttributedStringKeyMarkingBoldItalics: [NSNumber numberWithBool:YES]
        };
        
        _boldMarkingAttributes = @{
            WKEditorAttributedStringKeyMarkingBold: [NSNumber numberWithBool:YES]
        };
        
        _italicsMarkingAttributes = @{
            WKEditorAttributedStringKeyMarkingItalics: [NSNumber numberWithBool:YES]
        };
        
        _boldItalicsAttributes = @{
            NSFontAttributeName: fonts.boldItalicsFont,
            WKEditorAttributedStringKeyFontBoldItalics: [NSNumber numberWithBool:YES]
        };
        
        _boldAttributes = @{
            NSFontAttributeName: fonts.boldFont,
            WKEditorAttributedStringKeyFontBold: [NSNumber numberWithBool:YES]
        };
        
        _italicsAttributes = @{
            NSFontAttributeName: fonts.italicsFont,
            WKEditorAttributedStringKeyFontItalics: [NSNumber numberWithBool:YES]
        };
        
        _orangeAttributes = @{
            NSForegroundColorAttributeName: colors.orangeForegroundColor,
            WKEditorAttributedStringKeyColorOrange: [NSNumber numberWithBool:YES]
        };

        _boldItalicsRegex = [[NSRegularExpression alloc] initWithPattern:@"('{5})([^'\\n]*(?:'(?!'''')[^'\\n]*)*)('{5})" options:0 error:nil];
        _boldRegex = [[NSRegularExpression alloc] initWithPattern:@"('{3})([^'\\n]*(?:'(?!'')[^'\\n]*)*)('{3})" options:0 error:nil];
        
        // Explaining regex. There may be a more simple way to write this.
        // ('{2})       - matches opening ''. Captures in group so it can be orangified.
        // (            - start of capturing group that will be italisized.
        // [^'\n]*        - matches any character that isn't an apostrophe or line break zero or more times
        // (?:          - beginning of non-capturing group
        // (?<!')'(?!') - matches any apostrophes that are NOT preceded or followed by another ' (so single apostrophes in words like don't)
        // [^'\n]*        - matches any character that isn't a ' or line break zero or more times
        // )*           - end of non-capturing group, which can happen zero or more times (i.e. all single apostrophe logic)
        // )            - end of capturing group that will be italisized.
        // ('{2})       - matches ending ''. Captures in group so it can be orangified.
        _italicsRegex = [[NSRegularExpression alloc] initWithPattern:@"('{2})([^'\\n]*(?:(?<!')'(?!')[^'\\n]*)*)('{2})" options:0 error:nil];
    }
    return self;
}

- (void)applySyntaxHighlightRegexInAttributedString:(NSMutableAttributedString *)attributedString toRange:(NSRange)range {
    [super applySyntaxHighlightRegexInAttributedString:attributedString toRange:range];
    
    // Reset
    [attributedString removeAttribute:WKEditorAttributedStringKeyMarkingBoldItalics range:range];
    [attributedString removeAttribute:WKEditorAttributedStringKeyMarkingBold range:range];
    [attributedString removeAttribute:WKEditorAttributedStringKeyMarkingItalics range:range];
    
    [attributedString removeAttribute:WKEditorAttributedStringKeyFontBoldItalics range:range];
    [attributedString removeAttribute:WKEditorAttributedStringKeyFontBold range:range];
    [attributedString removeAttribute:WKEditorAttributedStringKeyFontItalics range:range];
    [attributedString removeAttribute:WKEditorAttributedStringKeyColorOrange range:range];
    
    NSMutableArray *filterRangeValues = [[NSMutableArray alloc] init];
    
    [self.boldItalicsRegex enumerateMatchesInString:attributedString.string
                                       options:0
                                         range:range
                                    usingBlock:^(NSTextCheckingResult *_Nullable result, NSMatchingFlags flags, BOOL *_Nonnull stop) {
                                        NSRange fullMatch = [result rangeAtIndex:0];
                                        NSRange openingRange = [result rangeAtIndex:1];
                                        NSRange textRange = [result rangeAtIndex:2];
                                        NSRange closingRange = [result rangeAtIndex:3];

                                        if (fullMatch.location != NSNotFound) {
                                            [filterRangeValues addObject:[NSValue valueWithRange:fullMatch]];
                                        }
        
                                        if (openingRange.location != NSNotFound) {
                                            [attributedString addAttributes:self.orangeAttributes range:openingRange];
                                        }

                                        if (textRange.location != NSNotFound) {
                                            [attributedString addAttributes:self.boldItalicsAttributes range:textRange];
                                            [attributedString addAttributes:self.boldItalicsMarkingAttributes range:textRange];
                                        }

                                        if (closingRange.location != NSNotFound) {
                                            [attributedString addAttributes:self.orangeAttributes range:closingRange];
                                        }
                                    }];
    
    [self.boldRegex enumerateMatchesInString:attributedString.string
                                       options:0
                                         range:range
                                    usingBlock:^(NSTextCheckingResult *_Nullable result, NSMatchingFlags flags, BOOL *_Nonnull stop) {
                                        NSRange fullMatch = [result rangeAtIndex:0];
                                        NSRange openingRange = [result rangeAtIndex:1];
                                        NSRange textRange = [result rangeAtIndex:2];
                                        NSRange closingRange = [result rangeAtIndex:3];
    
                                        BOOL alreadyFormatted = NO;
                                        for (NSValue *value in filterRangeValues) {
                                            NSRange filterRange = value.rangeValue;
                                            if (NSIntersectionRange(filterRange, fullMatch).length != 0) {
                                                alreadyFormatted = YES;
                                            }
                                        }

                                        if (alreadyFormatted) {
                                            return;
                                        }
        
                                        if (fullMatch.location != NSNotFound) {
                                            [filterRangeValues addObject:[NSValue valueWithRange:fullMatch]];
                                        }
        
                                        if (openingRange.location != NSNotFound) {
                                            [attributedString addAttributes:self.orangeAttributes range:openingRange];
                                        }

                                        if (textRange.location != NSNotFound) {
                                            [attributedString addAttributes:self.boldAttributes range:textRange];
                                            [attributedString addAttributes:self.boldMarkingAttributes range:textRange];
                                        }

                                        if (closingRange.location != NSNotFound) {
                                            [attributedString addAttributes:self.orangeAttributes range:closingRange];
                                        }
                                    }];

    [self.italicsRegex enumerateMatchesInString:attributedString.string
                                       options:0
                                         range:range
                                    usingBlock:^(NSTextCheckingResult *_Nullable result, NSMatchingFlags flags, BOOL *_Nonnull stop) {
                                        NSRange fullMatch = [result rangeAtIndex:0];
                                        NSRange openingRange = [result rangeAtIndex:1];
                                        NSRange textRange = [result rangeAtIndex:2];
                                        NSRange closingRange = [result rangeAtIndex:3];
        
                                        BOOL alreadyFormatted = NO;
                                        for (NSValue *value in filterRangeValues) {
                                            NSRange filterRange = value.rangeValue;
                                            if (NSIntersectionRange(filterRange, fullMatch).length != 0) {
                                                alreadyFormatted = YES;
                                            }
                                        }
        
                                        if (alreadyFormatted) {
                                            return;
                                        }
        
                                        if (fullMatch.location != NSNotFound) {
                                            [filterRangeValues addObject:[NSValue valueWithRange:fullMatch]];
                                        }
        
                                        if (openingRange.location != NSNotFound) {
                                            [attributedString addAttributes:self.orangeAttributes range:openingRange];
                                        }

                                        if (textRange.location != NSNotFound) {
                                            [attributedString addAttributes:self.italicsAttributes range:textRange];
                                            [attributedString addAttributes:self.italicsMarkingAttributes range:textRange];
                                        }

                                        if (closingRange.location != NSNotFound) {
                                            [attributedString addAttributes:self.orangeAttributes range:closingRange];
                                        }
                                    }];
}

- (void)updateColors:(WKSourceEditorTextStorageColors *)colors inAttributedString:(NSMutableAttributedString *)attributedString inRange:(NSRange)range {
    [super updateColors:colors inAttributedString:attributedString inRange:range];
    
    NSMutableDictionary *mutAttributes = [[NSMutableDictionary alloc] initWithDictionary:self.orangeAttributes];
    [mutAttributes setObject:colors.orangeForegroundColor forKey:NSForegroundColorAttributeName];
    self.orangeAttributes = [[NSDictionary alloc] initWithDictionary:mutAttributes];
    
    [attributedString enumerateAttribute:WKEditorAttributedStringKeyColorOrange
                     inRange:range
                     options:nil
                  usingBlock:^(id value, NSRange localRange, BOOL *stop) {
        if ([value isKindOfClass: [NSNumber class]]) {
            NSNumber *numValue = (NSNumber *)value;
            if ([numValue boolValue] == YES) {
                [attributedString addAttributes:self.orangeAttributes range:localRange];
            }
        }
    }];
}

- (void)updateFonts:(WKSourceEditorTextStorageFonts *)fonts inAttributedString:(NSMutableAttributedString *)attributedString inRange:(NSRange)range {
    [super updateFonts:fonts inAttributedString:attributedString inRange:range];
    NSMutableDictionary *mutBoldItalicsAttributes = [[NSMutableDictionary alloc] initWithDictionary:self.boldItalicsAttributes];
    [mutBoldItalicsAttributes setObject:fonts.boldItalicsFont forKey:NSFontAttributeName];
    self.boldItalicsAttributes = [[NSDictionary alloc] initWithDictionary:mutBoldItalicsAttributes];
    [attributedString enumerateAttribute:WKEditorAttributedStringKeyFontBoldItalics
                     inRange:range
                     options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired
                  usingBlock:^(id value, NSRange localRange, BOOL *stop) {
        if ([value isKindOfClass: [NSNumber class]]) {
            NSNumber *numValue = (NSNumber *)value;
            if ([numValue boolValue] == YES) {
                [attributedString addAttributes:self.boldItalicsAttributes range:localRange];
            }
        }
    }];

    NSMutableDictionary *mutBoldAttributes = [[NSMutableDictionary alloc] initWithDictionary:self.boldAttributes];
    [mutBoldAttributes setObject:fonts.boldFont forKey:NSFontAttributeName];
    self.boldAttributes = [[NSDictionary alloc] initWithDictionary:mutBoldAttributes];
    [attributedString enumerateAttribute:WKEditorAttributedStringKeyFontBold
                     inRange:range
                     options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired
                  usingBlock:^(id value, NSRange localRange, BOOL *stop) {
        if ([value isKindOfClass: [NSNumber class]]) {
            NSNumber *numValue = (NSNumber *)value;
            if ([numValue boolValue] == YES) {
                [attributedString addAttributes:self.boldAttributes range:localRange];
            }
        }
    }];

    
    NSMutableDictionary *mutItalicsAttributes = [[NSMutableDictionary alloc] initWithDictionary:self.italicsAttributes];
    [mutItalicsAttributes setObject:fonts.italicsFont forKey:NSFontAttributeName];
    self.italicsAttributes = [[NSDictionary alloc] initWithDictionary:mutItalicsAttributes];
    
    [attributedString enumerateAttribute:WKEditorAttributedStringKeyFontItalics
                     inRange:range
                     options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired
                  usingBlock:^(id value, NSRange localRange, BOOL *stop) {
        if ([value isKindOfClass: [NSNumber class]]) {
            NSNumber *numValue = (NSNumber *)value;
            if ([numValue boolValue] == YES) {
                [attributedString addAttributes:self.italicsAttributes range:localRange];
            }
        }
    }];
}

- (BOOL)attributedString:(NSMutableAttributedString *)attributedString isBoldInRange:(NSRange)range {
    __block BOOL isBold = NO;
    [attributedString enumerateAttributesInRange:range options:nil usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
            if (attrs[WKEditorAttributedStringKeyMarkingBoldItalics] != nil || attrs[WKEditorAttributedStringKeyMarkingBold] != nil) {
                isBold = YES;
                stop = YES;
            }
    }];
    
    return isBold;
}
- (BOOL)attributedString:(NSMutableAttributedString *)attributedString isItalicsInRange:(NSRange)range {
    __block BOOL isItalics = NO;
    [attributedString enumerateAttributesInRange:range options:nil usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
            if (attrs[WKEditorAttributedStringKeyMarkingBoldItalics] != nil || attrs[WKEditorAttributedStringKeyMarkingItalics] != nil) {
                isItalics = YES;
                stop = YES;
            }
    }];
    
    return isItalics;
}

@end
