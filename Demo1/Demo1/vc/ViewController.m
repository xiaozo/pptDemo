//
//  ViewController.m
//  Demo1
//
//  Created by DeerClass on 2022/9/8.
// #import  <CoreBluetooth/CoreBluetooth.h>

#import "ViewController.h"
#import "PhoneItem.h"
#import "PhoneItemViewCell.h"
#import "YYModel.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *currentPhoneList;
    UILabel *headLbl;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *allPhoneList;

@property (strong, nonatomic) NSMutableArray *noAnswerPhoneList;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightBarButtonItem;


@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self readPhoneData];
    
    [self initTableView];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
 

    
}

///1读取模拟数据
- (void)readPhoneData {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"phone" ofType:@"json"];
     NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    self.allPhoneList = [NSArray yy_modelArrayWithClass:[PhoneItem class] json:str].mutableCopy;
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"isAnswer==NO"];
    self.noAnswerPhoneList = [self.allPhoneList filteredArrayUsingPredicate:predicate].mutableCopy;
    
    currentPhoneList = self.allPhoneList;
   
}

- (void)initTableView {
    [self.tableView registerNib:[UINib nibWithNibName:@"PhoneItemViewCell" bundle:nil] forCellReuseIdentifier:@"PhoneItemViewCellId"];
    
//    [self.tableView registerClass:PhoneItemViewCell.class forCellReuseIdentifier:@"PhoneItemViewCellId"];
    
    self.tableView.tableFooterView = [UIView new];
    
    UIView *headView = [[UIView alloc] init];
    
    headLbl = [[UILabel alloc] init];
    headLbl.text = @"最近通话";
    headLbl.font = [UIFont boldSystemFontOfSize:36.0];
    [headLbl sizeToFit];
//    headLbl.layer.anchorPoint = CGPointMake(0, 1);
    headLbl.frame = CGRectMake(20, 10, headLbl.frame.size.width, headLbl.frame.size.height);
   
    headView.frame = CGRectMake(0, 0, headLbl.frame.size.width, headLbl.frame.size.height);
    self.tableView.tableHeaderView = headView;
    [headView addSubview:headLbl];
    
}

- (IBAction)selectTabAction:(UISegmentedControl *)sender {
    currentPhoneList = sender.selectedSegmentIndex == 1 ? self.noAnswerPhoneList : self.allPhoneList;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    
}

- (IBAction)rightAction:(UIBarButtonItem *)item {
    if ([item.title isEqualToString:@"编辑"]) {

        item.title = @"完成";
        [self.tableView setEditing:YES animated:YES];
        [self showEitingView:YES];

    }else{
        item.title = @"编辑";
        [self.tableView setEditing:NO animated:YES];
        [self showEitingView:NO];
    }
}

- (void)showEitingView:(BOOL)isShow {
    [[self.tableView visibleCells] enumerateObjectsUsingBlock:^(__kindof PhoneItemViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj adjuestView:isShow animated:YES];
    }];
}

#pragma mark --- tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return currentPhoneList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PhoneItem *item = currentPhoneList[indexPath.row];
    
//    PhoneItemViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"PhoneItemViewCell" owner:self options:nil].firstObject;
    PhoneItemViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhoneItemViewCellId"];
    cell.phoneItem = item;
//    [cell setNeedsUpdateConstraints];
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [(PhoneItemViewCell *)cell adjuestView:tableView.isEditing animated:NO];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath {
    
    [currentPhoneList removeObjectAtIndex:indexPath.row];
    
    [tableView beginUpdates];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [tableView endUpdates];
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //获取storyboard: 通过bundle根据storyboard的名字来获取我们的storyboard,
//           UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//
//           //由storyboard根据myView的storyBoardID来获取我们要切换的视图
//           UIViewController *myView = [story instantiateViewControllerWithIdentifier:@"viewid"];
//
//           //由navigationController推向我们要推向的view
//           [self.navigationController pushViewController:myView animated:YES];
}

- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath*)indexPath {
    _rightBarButtonItem.title = @"完成";
}
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(nullable NSIndexPath *)indexPath {
    _rightBarButtonItem.title = @"编辑";
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//   CGFloat y = scrollView.contentOffset.y;
//
//    if (y <= 0) {
//        CGFloat scale = MIN(-y / 150.0 * 0.3 + 1.0, 1.3);
//        headLbl.transform = CGAffineTransformMakeScale(scale, scale);
//    } else {
//        headLbl.transform = CGAffineTransformIdentity;
//    }
//}

@end
