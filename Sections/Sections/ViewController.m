//
//  ViewController.m
//  Sections
//
//  Created by Shiina Mashiro on 15/10/3.
//  Copyright © 2015年 Shiina Mashiro. All rights reserved.
//

#import "ViewController.h"
static NSString *SectionsTableIdentifier = @"SectionsTableIdentifier";


@interface ViewController ()

@property (copy, nonatomic) NSDictionary *names;
@property (copy, nonatomic) NSArray *keys;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITableView *tableView = (id)[self.view viewWithTag:1];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:SectionsTableIdentifier];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sortednames" ofType:@"plist"];
    self.names = [NSDictionary dictionaryWithContentsOfFile:path];
    self.keys = [[self.names allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    if (tableView.style == UITableViewStylePlain) {
        UIEdgeInsets contentInset = tableView.contentInset;
        contentInset.top = 20;
        [tableView setContentInset:contentInset];
        
        UIView *barBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
        barBackground.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0];
        [self.view addSubview:barBackground];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -
#pragma mark Table View Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.keys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = self.keys[section];
    NSArray *nameSection = self.names[key];
    return [nameSection count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.keys[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SectionsTableIdentifier forIndexPath:indexPath];
    NSString *key = self.keys[indexPath.section];
    NSArray *nameSection = self.names[key];
    
    cell.textLabel.text = nameSection[indexPath.row];
    return cell;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.keys;
}

@end
