import UIKit

extension StepCountViewController {
    
    func configureView() {
        view.addSubview(greyedView)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(displayImage)
        contentView.addSubview(stackView)
        stackView.addSubview(stepsText)
        stackView.addSubview(monthText)
        contentView.addSubview(stepsCountText)
        contentView.addSubview(lineCharts)
        contentView.addSubview(achievementLabel)
        contentView.addSubview(numberOfAchievements)
        contentView.addSubview(acheivementCollectionView)
        
        configureGreyedView()
        configureScrollView()
        configurContentView()
        configureDisplayImage()
        configureStackView()
        configureStepsText()
        configureMonthText()
        configureStepsCountText()
        configureLineCharts()
        configureAchievementLabel()
        configureNumberOfAchievements()
        configureAchievementCollectionView()
        
        self.setUpNavigationBar()
        setDelegates()
        configureChart(dataPoints: months, values: unitsSold)
        configureLineChartView()
    }
    
    func configureGreyedView() {
        greyedView.snp.makeConstraints({ make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(1)
            make.left.right.equalTo(view)
        })
    }
    
    func configureScrollView() {
        scrollView.snp.makeConstraints({ make in
            make.top.equalTo(greyedView.snp.bottom)
            make.right.left.bottom.equalTo(self.view)
        })
    }
    
    func configurContentView() {
        contentView.snp.makeConstraints({ make in
            make.top.equalTo(scrollView)
            make.left.right.equalTo(scrollView)
            make.width.height.equalTo(scrollView)
        })
    }
    
    func configureDisplayImage() {
        displayImage.snp.makeConstraints({ make in
            make.top.equalTo(contentView).offset(23)
            make.width.height.equalTo(180)
            make.centerX.equalTo(contentView.snp.centerX)
        })

    }
    
    func configureStackView() {
        stackView.snp.makeConstraints({ make in
            make.top.equalTo(displayImage.snp.bottom).offset(17.5)
            make.left.equalTo(contentView).offset(24)
        })
    }
    
    func configureStepsText() {
        stepsText.snp.makeConstraints({ make in
            make.left.top.equalTo(stackView)
            make.width.equalTo(173)
        })
    }
    
    func configureStepsCountText() {
        stepsCountText.snp.makeConstraints({ make in
            make.right.equalTo(contentView).inset(24.72)
            make.top.equalTo(displayImage.snp.bottom).offset(17.5)
            make.left.equalTo(stepsText.snp.right).offset(8.04)
        })
    }
    
    func configureMonthText() {
        monthText.snp.makeConstraints({ make in
            make.top.equalTo(stepsText.snp.bottom)
            make.left.equalTo(stackView)
        })
    }
    
    func configureLineCharts() {
        lineCharts.snp.makeConstraints({ make in
            make.top.equalTo(stepsCountText.snp.bottom).offset(25)
            make.left.equalTo(contentView).offset(0)
            make.right.equalTo(contentView).inset(0)
            make.height.equalTo(141)
        })
    }
    
    func configureAchievementLabel() {
        achievementLabel.snp.makeConstraints({ make in
            make.left.equalTo(contentView).offset(24)
            make.top.equalTo(lineCharts.snp.bottom).offset(44)
        })
    }
    
    func configureNumberOfAchievements() {
        numberOfAchievements.snp.makeConstraints({ make in
            make.top.equalTo(lineCharts.snp.bottom).offset(44)
            make.right.equalTo(contentView).inset(24)
        })
    }
    
    func configureAchievementCollectionView() {
        acheivementCollectionView.snp.makeConstraints({ make in
            make.top.equalTo(achievementLabel.snp.bottom).offset(18)
            make.left.equalTo(contentView).offset(24)
            make.right.equalTo(contentView).inset(24)
            make.height.equalTo(176)
        })
    }
    
}
