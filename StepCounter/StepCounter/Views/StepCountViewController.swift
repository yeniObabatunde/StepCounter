import UIKit
import DGCharts
import SnapKit
import Charts
import HealthKit

class StepCountViewController: UIViewController {
    
    private var healthStore: HealthStore?
    var achievementViewModel: AcheivementViewModel?
    var acheivementData: [AcheivementModels] = []
    var date = (Date.getCurrentMonth() + " - " + Date().getFormattedDate()).replacingOccurrences(of: ",", with: " ")
    
    var totalSteps: Double = 0 {
        didSet {
            setupViews()
        }
    }
    
    init() {
        healthStore = HealthStore()
        achievementViewModel = AcheivementViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var dataEntry = ChartDataEntry()
    let colors = Colors()
    var dataEntries: [ChartDataEntry] = []
    let months = ["1", "5", "10", "15", "20", "25", "30"]
    let unitsSold = [7.0, 5.0, 7.0, 5.0, 9.0, 8.0, 9.0]
    var width: Double = (UIScreen.main.bounds.width / 4)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Colors.blackColor
        refreshControl()
        updateUIDataFromStatisticsGottenFromHealthStore()
        setupViews()
        configureView()
        
    }
    
    func refreshControl() {
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        //        self.healthStore?.check()
    }
    
    @objc func didPullToRefresh() {
        DispatchQueue.main.async {
            self.scrollView.refreshControl?.beginRefreshing()
            self.healthStore?.startObservingStepCountChanges()
            self.didStopRefreshing()
        }
    }
    
    func didStopRefreshing() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.scrollView.refreshControl?.endRefreshing()
        })
    }
    
    func fetchDataFromCoreData() {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 200)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    lazy var greyedView: UIView = {
        var greyedView = UIView()
        greyedView.backgroundColor = Constants.Colors.grayedColor
        return greyedView
    }()
    
    lazy var scrollView: UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.autoresizingMask = .flexibleHeight
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = true
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        var contentView = UIView()
        return contentView
    }()
    
    lazy var displayImage: UIImageView = {
        var displayImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 180, height: 180))
        displayImage.image = UIImage(named: Constants.Images.displayImage)
        let frame = CGRect(x: 0, y: 0, width: width, height: width)
        displayImage.makeImageRounded()
        return displayImage
    }()
    
    lazy var stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var stepsText: UILabel = {
        var stepsText = UILabel()
        stepsText.font = UIFont(name: Constants.Fonts.SFProDisplay, size: 32)
        stepsText.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        stepsText.textColor = Constants.Colors.whiteColor
        stepsText.text = Constants.StepCountControllerUIText.stepsText
        return stepsText
    }()
    
    lazy var monthText: UILabel = {
        var monthText = UILabel()
        monthText.text = date
        monthText.textColor = Constants.Colors.grayedColor
        monthText.font = UIFont(name: Constants.Fonts.SFProDisplay, size: 18)
        return monthText
    }()
    
    lazy var stepsCountText: UILabel = {
        var stepsText = UILabel()
        stepsText.textAlignment = .right
        stepsText.text = "0.0"
        stepsText.font = UIFont(name:Constants.Fonts.SFProDisplay, size: 32)
        stepsText.textColor = Constants.Colors.greenColor
        return stepsText
    }()
    
    lazy var lineCharts: LineChartView = {
        var lineCharts = LineChartView()
        lineCharts.leftAxis.enabled = false
        
        var yaxis = lineCharts.rightAxis
        yaxis.labelTextColor = Constants.Colors.grayedColor ?? UIColor.gray
        yaxis.labelPosition = .insideChart
        yaxis.labelFont = UIFont.systemFont(ofSize: 11)
        yaxis.setLabelCount(6, force: false)
        
        var xaxis = lineCharts.xAxis
        xaxis.labelPosition = .bottom
        xaxis.labelTextColor = .white
        return lineCharts
    }()
    
    lazy var achievementLabel: UILabel = {
        var achievementLabel = UILabel()
        achievementLabel.text = Constants.StepCountControllerUIText.achievements
        achievementLabel.textColor = Constants.Colors.whiteColor
        achievementLabel.font = UIFont(name: Constants.Fonts.SFProDisplay, size: 24)
        achievementLabel.font = .boldSystemFont(ofSize: 24)
        return achievementLabel
    }()
    
    lazy var numberOfAchievements: UILabel = {
        var numberOfAchievements = UILabel()
        numberOfAchievements.textColor = Constants.Colors.blueColor
        numberOfAchievements.font = UIFont(name: Constants.Fonts.SFProDisplay, size: 24)
        numberOfAchievements.font = .boldSystemFont(ofSize: 24)
        return numberOfAchievements
    }()
    
    lazy var acheivementCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.backgroundColor = Constants.Colors.blackColor
        collectionView.register(AchievementCollectionCells.self, forCellWithReuseIdentifier: AchievementCollectionCells.cellIdentifier)
        return collectionView
    }()
    
    func setDelegates() {
        acheivementCollectionView.delegate = self
        acheivementCollectionView.dataSource = self
    }
    
    func configureChart(dataPoints: [String], values: [Double]) {
        for i in 0..<dataPoints.count {
            dataEntry = ChartDataEntry(x: Double(i), y: values[i], data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
        }
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "")
        chartDataSet.drawValuesEnabled = false
        chartDataSet.setColor(Constants.Colors.gradientBlueColor ?? .black)
        chartDataSet.lineWidth = 3
        chartDataSet.mode = .cubicBezier
        chartDataSet.drawCirclesEnabled = false
        let chartData = LineChartData(dataSets: [chartDataSet])
        lineCharts.data = chartData
    }
    
    func configureLineChartView() {
        let xAxis = lineCharts.xAxis
        xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        xAxis.labelPosition = .bottom
        xAxis.drawGridLinesEnabled = false
        lineCharts.rightAxis.enabled = true
        xAxis.labelTextColor = Constants.Colors.grayedColor ?? .black
        xAxis.labelFont = UIFont(name: Constants.Fonts.SFProDisplay, size: 11) ?? UIFont.systemFont(ofSize: 11)
        lineCharts.rightAxis.drawAxisLineEnabled = false
        xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        xAxis.setLabelCount(months.count, force: true)
        
        let rightAxis = lineCharts.rightAxis
        rightAxis.enabled = true
        rightAxis.labelCount = 3
        rightAxis.xOffset = 16
        rightAxis.yOffset = -2
        
        lineCharts.doubleTapToZoomEnabled = true
        lineCharts.animate(xAxisDuration: 1.5)
        lineCharts.isUserInteractionEnabled = false
    }
    
    func updateUIDataFromStatisticsGottenFromHealthStore() {
        if let healthStore = healthStore {
            DispatchQueue.main.async { [weak self] in
                healthStore.requestAuthorization { success in
                    if success{
                        healthStore.CalculateStepsforAmonth { [self] statisticsCollection in
                            if let statisticsCollection = statisticsCollection {
                                self?.updateFromStaticticsGotten(statisticsCollection)
                            }
                        }
                    } else {
                        print("Failure !!!!!!!!!")
                    }
                }
            }
        } else {
            print("Cannot find health store")
        }
    }
    
    func updateFromStaticticsGotten(_ statisticsCollection: HKStatisticsCollection) {
        let startDate = Date().startOfDay()
        let endDate =  Date()
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) {
            (statisticsCollection, _) in
            
            if let count = statisticsCollection.sumQuantity() {
                let totalNumberOfStep = count.doubleValue(for: HKUnit.count())
                if totalNumberOfStep <= 0 {
                    self.totalSteps = 0
                }
                else {
                    print(Array(arrayLiteral: totalNumberOfStep), ":This is the total number of step for each of the days of the month")
                    self.totalSteps += totalNumberOfStep
                    DispatchQueue.main.async {
                        self.stepsCountText.text = "\(self.totalSteps)"
                    }
                }
            }
        }
    }
    
    func setupViews() {
        
        var data: [AcheivementModels] = []
        var hasAchievement: Bool = false
        let acheivementModel = achievementViewModel?.presentCollectionCells() ?? []
        print(totalSteps, "😎😎😎😎😎😎😎")
        if totalSteps < 10000 {
            data.append(acheivementModel[0])
        }
        for num in stride(from: 10000, to: totalSteps, by: 5000) {
            hasAchievement = true
            if num >= 45000 || num < 10000{
                break
            }
            let count = (num - 5000) / 5000
            data.append(acheivementModel[Int(count)])
        }
        acheivementData = data
        DispatchQueue.main.async {
            self.acheivementCollectionView.reloadData()
            self.numberOfAchievements.text = hasAchievement ? String(data.count): "0"
        }
        
    }
    
    func enableDarkMode() {
        switch traitCollection.userInterfaceStyle {
            case.dark:
                break
            case.light:
                break
            default:
                print("")
        }
    }
    
}


//chartDataSet.colors = [NSUIColor(cgColor: Constants.Colors.gradientGreenColor!.cgColor),
//                       NSUIColor(cgColor: Constants.Colors.gradientGreenColor!.cgColor)]
//

//let gradient = CAGradientLayer()
//gradient.colors = [
//    UIColor.red.cgColor,
//    UIColor.orange.cgColor,
//    UIColor.yellow.cgColor,
//    UIColor.green.cgColor
//]
//gradient.startPoint = CGPoint(x: 0.5, y: 0)
//gradient.endPoint = CGPoint(x: 0.5, y: 1)
//gradient.mask = lineCharts
