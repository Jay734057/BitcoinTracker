//
//  BitcoinTrackerViewController.m
//  BitcoinTracker
//
//  Created by Jianyu ZHU on 2/11/17.
//  Copyright © 2017 Unimelb. All rights reserved.
//

#import "BitcoinTrackerViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <SVProgressHUD/SVProgressHUD.h>

#define REQUEST_URL @"https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
#define CURRENCY_ARRAY @[@"AUD", @"BRL",@"CAD",@"CNY",@"EUR",@"GBP",@"HKD",@"IDR",@"ILS",@"INR",@"JPY",@"MXN",@"NOK",@"NZD",@"PLN",@"RON",@"RUB",@"SEK",@"SGD",@"USD",@"ZAR"]
#define CURRENCY_SYMBOL @[@"$", @"R$", @"$", @"¥", @"€", @"£", @"$", @"Rp", @"₪", @"₹", @"¥", @"$", @"kr", @"$", @"zł", @"lei", @"₽", @"kr", @"$", @"$", @"R"]

@interface BitcoinTrackerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *bitcoinPrice;
@property (weak, nonatomic) IBOutlet UIPickerView *currencyPicker;

@end

@implementation BitcoinTrackerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currencyPicker.delegate = self;
    self.currencyPicker.dataSource = self;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return CURRENCY_ARRAY.count;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [SVProgressHUD show];
    [self getPriceWithUrl:[NSString stringWithFormat:@"%@%@",REQUEST_URL, [CURRENCY_ARRAY objectAtIndex:row]]];
}

-(NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [[NSAttributedString alloc] initWithString:[CURRENCY_ARRAY objectAtIndex:row] attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

-(void)getPriceWithUrl: (NSString *)url {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        [self updateUIWithDictionary:responseObject];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        self.bitcoinPrice.text = @"Connection Issue!";
        [SVProgressHUD dismiss];
    }];
}

-(void)updateUIWithDictionary: (NSDictionary *) dictionary{
    double price = [[[dictionary objectForKey:@"averages"] objectForKey:@"day"] doubleValue];
    if (price) {
        self.bitcoinPrice.text = [NSString stringWithFormat:@"%@%.2f", [CURRENCY_SYMBOL objectAtIndex:[self.currencyPicker selectedRowInComponent:0]], price];
    } else {
        self.bitcoinPrice.text = @"Price Unavailable!";
    }
}

@end
