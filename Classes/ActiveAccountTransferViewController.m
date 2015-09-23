//
//  ActiveAccountTransferViewController.m
//  Telephone
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//  1. Redistributions of source code must retain the above copyright notice,
//     this list of conditions and the following disclaimer.
//  2. Redistributions in binary form must reproduce the above copyright notice,
//     this list of conditions and the following disclaimer in the documentation
//     and/or other materials provided with the distribution.
//  3. Neither the name of the copyright holder nor the names of contributors
//     may be used to endorse or promote products derived from this software
//     without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
//  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
//  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE THE COPYRIGHT HOLDER
//  OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
//  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
//  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
//  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
//  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
//  OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
//  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "ActiveAccountTransferViewController.h"

#import "AccountController.h"


@implementation ActiveAccountTransferViewController

- (instancetype)initWithAccountController:(AccountController *)accountController {
    if ((self = [super initWithNibName:@"ActiveAccountTransferView" bundle:nil])) {
        self.accountController = accountController;
    }
    return self;
}

- (IBAction)makeCallToTransferDestination:(id)sender {
    if ([[[self callDestinationField] objectValue] count] == 0) {
        return;
    }
    
    NSDictionary *callDestinationDict = [[[[self callDestinationField] objectValue] objectAtIndex:0]
                                         objectAtIndex:[self callDestinationURIIndex]];
    
    NSString *phoneLabel = [callDestinationDict objectForKey:kPhoneLabel];
    
    AKSIPURI *uri = [self callDestinationURI];
    if (uri != nil) {
        [[self accountController] makeCallToURI:uri
                                     phoneLabel:phoneLabel
                         callTransferController:(CallTransferController *)[[sender window] windowController]];
    }
}

- (IBAction)makeCall:(id)sender {
    return;
}

@end
