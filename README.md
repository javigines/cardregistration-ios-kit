## MANGOPAY iOS

### PROJECT SETTINGS

Step 1 - Add the following to your Info.plist will disable ATS in iOS 9.

    <key>NSAppTransportSecurity</key>
      <dict>
      <key>NSAllowsArbitraryLoads</key>
      <true/>
    </dict>

### SAMPLE USAGE

Step 2

    #import <mangopay/mangopay.h>

Step 3

    @interface ViewController ()
    @property (nonatomic, strong) MPAPIClient *mangopayClient;
    @end

Initiate MPAPIClient with received cardObject

    self.mangopayClient = [[MPAPIClient alloc] initWithCardObject:responseObject];

Collect card info from the user and add it to mangopayClient

    [self.mangopayClient.cardObject setCardNumber:@"4970100000000154"];
    [self.mangopayClient.cardObject setCardExpirationDate:@"1016"];
    [self.mangopayClient.cardObject setCardCvx:@"123"];

Register card

    [self.mangopayClient registerCard:^(NSDictionary *response, NSError *error) {
          if (error) {
              NSLog(@"Error: %@", error);
          }
          else { // card was VALIDATED
              NSLog(@"VALIDATED %@", response);
          }
    }];
