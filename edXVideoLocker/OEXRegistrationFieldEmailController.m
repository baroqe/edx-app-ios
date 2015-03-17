//
//  RegistraionFieldEmailController.m
//  edXVideoLocker
//
//  Created by Jotiram Bhagat on 13/02/15.
//  Copyright (c) 2015 edX. All rights reserved.
//

#import "OEXRegistrationFieldEmailController.H"
#import "OEXRegistrationFormField.h"
#import "NSString+OEXValidation.h"
#import "OEXRegistrationFieldValidator.h"
@interface OEXRegistrationFieldEmailController ()
@property(nonatomic, strong) OEXRegistrationFormField* field;
@property(nonatomic, strong) OEXRegistrationFieldEmailView* view;
@end

@implementation OEXRegistrationFieldEmailController

-(instancetype)initWithRegistrationFormField:(OEXRegistrationFormField*)field {
    self = [super init];
    if(self) {
        self.field = field;
        self.view = [[OEXRegistrationFieldEmailView alloc] init];
        self.view.instructionMessage = field.instructions;
        self.view.placeholder = field.label;
    }
    return self;
}

-(NSString*)currentValue {
    return [[self.view currentValue] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

-(BOOL)hasValue {
    return [self currentValue] && ![[self currentValue] isEqualToString:@""];
}

-(void)handleError:(NSString*)errorMsg {
    [self.view setErrorMessage:errorMsg];
}

-(BOOL)isValidInput {
    NSString* errorMesssage = [OEXRegistrationFieldValidator validateField:self.field withText:[self currentValue]];
    if(errorMesssage) {
        [self handleError:errorMesssage];
        return NO;
    }

    if([self hasValue] && ![[self currentValue] oex_isValidEmailAddress]) {
        [self handleError:@"Please make sure your e-mail address is formatted correctly and try again."];
        return NO;
    }

    return YES;
}
@end