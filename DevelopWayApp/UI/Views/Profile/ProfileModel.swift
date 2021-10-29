//
//  ProfileModel.swift
//  DevelopWayApp
//
//  Created by Diana Sargsyan on 29.10.21.
//

import Foundation
import SwiftUI
import SwiftUICharts

class ProfileModel: ObservableObject {
    
    var user: User
    
    var profileImage: UIImage?
    
    @Published var chartInfo: [UserEntity] = [UserEntity]()
    var chartData : RangedBarChartData = RangedBarChartData(dataSets: RangedBarDataSet(dataPoints: []))
    
    init(entity: UserEntity?) {
        if let info = entity {
            self.user = User.init(entity: info)
        } else {
            self.user = User()
        }
        tryGetImage()
        fetchinfoforChart()
        chartData = weekOfData()
    }
    
    func weekOfData() -> RangedBarChartData {
        let formatter = DateFormatter()
        let data : RangedBarDataSet =
            RangedBarDataSet(dataPoints: chartInfo.compactMap({ item in
                
                formatter.dateFormat = "dd/MM/yy hh:mm"
                var x = ""
                if let birthday = item.createdDate {
                    x = formatter.string(from: birthday)
                }
                
                return RangedBarDataPoint(lowerValue: 0, upperValue: Double(item.id), xAxisLabel: x, description: item.name, date: item.createdDate)
            }),
            legendTitle: "ID")
        
        let gridStyle  = GridStyle(numberOfLines: 11,
                                   lineColour  : Color(.lightGray).opacity(0.25),
                                   lineWidth   : 1)
        
        let chartStyle = BarChartStyle(infoBoxPlacement   : .infoBox(isStatic: false),
                                       xAxisGridStyle     : gridStyle,
                                       xAxisLabelPosition : .bottom,
                                       xAxisLabelsFrom    : .dataPoint(rotation: .degrees(90)),
                                       yAxisGridStyle     : gridStyle,
                                       yAxisLabelPosition : .leading,
                                       yAxisNumberOfLabels: 11,
                                       baseline: .zero,
                                       topLine: .maximum(of: 100))
        
        return RangedBarChartData(dataSets: data,
                                  metadata: ChartMetadata(title: "Users", subtitle: ""),
                                  xAxisLabels: ["00:00", "12:00", "00:00"],
                                  barStyle: BarStyle(barWidth: 0.75,
                                                     cornerRadius: CornerRadius(top: 10, bottom: 10),
                                                     colourFrom: .barStyle,
                                                     colour: ColourStyle(colours: [Color.darkBlue,
                                                          Color.neoCyan],
                                                    startPoint: .bottom, endPoint: .top)),
                                  chartStyle: chartStyle)
    }
    
    func tryGetImage() {
        if let imageURL = user.imageURL, let url = URL(string: imageURL) {
            if FileManager.default.fileExists(atPath: imageURL) {
                do {
                    let data = try Data(contentsOf: url)
                    profileImage = UIImage(data: data)
                }
                catch {
                    //ERROR
                }
            }
        }
    }
    
    let formatter = DateFormatter()
    
    private func fetchinfoforChart() {
        if let array = CoreDataManager.sharedManager.getUsers() {
            chartInfo = array.sorted(by: { $0.createdDate?.compare($1.createdDate ?? Date()) == .orderedDescending })
        }
    }
}

extension ProfileModel {
    class User {
        let name: String
        let surname: String
        let gender: Gender
        let email: String
        var birthday: String = ""
        let imageURL: String?
        
        let formatter = DateFormatter()
        
        init() {
            self.name = ""
            self.surname = ""
            self.email = ""
            self.gender = Gender.women
            self.imageURL = nil
        }
        
        init(entity: UserEntity) {
            self.name = entity.name ?? ""
            self.surname = entity.surname ?? ""
            self.email = entity.email ?? ""
            self.gender = Gender.init(rawValue: entity.gender ?? "") ?? .women
            self.imageURL = entity.imageURL
            
            formatter.dateFormat = "dd/MM/YYYY"
            if let birthday = entity.birthday {
                self.birthday = formatter.string(from: birthday)
            }
        }
    }
}
