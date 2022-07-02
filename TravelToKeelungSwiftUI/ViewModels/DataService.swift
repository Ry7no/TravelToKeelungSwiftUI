//
//  DataService.swift
//  TravelToKeelungSwiftUI
//
//  Created by Br7 on 2022/6/19.
//

import MapKit
import Foundation

class DataServiceViewModel: ObservableObject {
    
    var locations: [Location] = []
    var locationFromJsons: [LocationFromJson] = []
    
    init(){
        JSONParser(name: "KeelungCoastView")
        appendLocation()
    }
    
    func JSONParser(name: String) {
        if let path = Bundle.main.path(forResource: name, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let locationFromJsons = try JSONDecoder().decode([LocationFromJson].self, from: data)
                self.locationFromJsons = locationFromJsons
                print(locationFromJsons.count)
              } catch {
                   // handle error
              }
        }
    }
    
    func appendLocation(){
        locationFromJsons.forEach { LocationFromJson in
            let name = LocationFromJson.cName
            let cityName = "基隆市"
            let coordinates = CLLocationCoordinate2D(latitude: Double(LocationFromJson.px) ?? 25.0, longitude: Double(LocationFromJson.py) ?? 121.0)
            let description = LocationFromJson.cToldescribe
            let imageUrl = LocationFromJson.picture1
            let imageTitle = LocationFromJson.picdescribe1C
            let phone = LocationFromJson.tel
            let address = LocationFromJson.cAdd
            let link = LocationFromJson.website
            
            self.locations.append(Location(name: name, cityName: cityName, coordinates: coordinates, description: description, imageUrl: imageUrl, imageTitle: imageTitle, phone: phone, address: address, link: link))
        }
        print("self.locations.count: \(self.locations.count)")
    }
}

//static var locations: [Location] = [
//        Location(name: "大武崙砲台",
//                 cityName: "基隆",
//                 coordinates: CLLocationCoordinate2D(latitude: 25.15868, longitude: 121.70935),
//                 description: "大武崙砲台位於基隆西北方，居外木山漁港後的大武崙山上，也就是情人湖的上方。因其地勢險要，而成為守基隆港西側的重要據點，在道光二十年（西元1840年）的清英鴉片戰爭及光緒十年（西元1884年）的清法戰爭時，清政府均曾派兵駐防。但據其構造及設計特色來看，應為日治時期所改建之結果，為國定古蹟，位於大武崙山巔，地形居高臨下，地勢非常險要，其標高為231公尺，可向西對準情人湖，北俯大武崙澳，東望基隆港及東海。區域幽靜，林木翠綠，登上環道的短邊眺望四周，基隆嶼、外木山澳漁村、八斗子、北海岸一帶的秀麗風光盡收眼底，是一處觀景，談心的好地，也常為婚紗公司取景之選擇，增添它浪漫的風情。",
//                 imageUrl: "https://keelungfarm.klcg.gov.tw/Upload/FileManager/a26df8b9-90f4-4fd7-9a01-9f9aeaced5eb.jpg",
//                 imageTitle: "大武崙砲台",
//                 link: ""),
//        Location(name: "二沙灣砲台",
//                 cityName: "基隆",
//                 coordinates: CLLocationCoordinate2D(latitude: 25.13766, longitude: 121.75742),
//                 description: "二沙灣砲台又名海門天險，為國定古蹟，位於中正公園二沙灣山上，採用傳統的中式城門築法，依山而建，氣勢雄偉。原位於二沙灣海邊的砲臺，創建年代約在清道光年間（西元1840年），之後砲台被毀，現址為劉銘傳部隊於清法戰爭後（西元1885年）所建，深具歷史價值。二沙灣砲台屬高地砲台中的「抱山式砲台」，不同於一般砲台，砲台建在地勢較高的臨海山頭，營盤設計在背海面地勢較低之處，海上來犯敵艦的砲彈只會打到山崗向海的一面，或越過山頭落到谷底，很難擊中營區。其與位於外海口門的社寮、白米甕構成鐵三角防禦網，防守基隆內、外港。二沙灣砲台現存建築，如城門、營舍牆基、大階梯、砲座、子牆及儲彈藥庫，各有其特色；砲座、子牆均使用鐵水泥建造而成，另砲台區內並有仿製之古砲數門；又因居高臨下，視野寬廣，遊客可於砲座俯瞰港口，體會「海門天險」的氣勢，景觀絕佳。砲台全區步道林木密佈，其間有鳥類及昆蟲，可在參觀古蹟之餘另有一生動自然之美。",
//                 imageUrl: "https://keelungfarm.klcg.gov.tw/Upload/FileManager/6ead48e5-9e65-4997-aadd-54309a81edd0.jpg",
//                 imageTitle: "二沙灣砲台",
//                 link: ""),
//        Location(name: "白米甕砲台",
//                 cityName: "基隆",
//                 coordinates: CLLocationCoordinate2D(latitude: 25.15552, longitude: 121.74418),
//                 description: "白米甕砲台位於基隆市中山區，大約建於清朝光緒年間，而今日之所見為日治時期所改建過後的景象，設計觀念及設施配置方面是較先進的作法，而且用材及施工亦頗為精良，雖歷經多年滄桑，但格局仍然保持完整；白米甕砲台周圍當地人舊稱『荷蘭城』，由於荷蘭據台時期就築有堡壘之類的建築，故白米甕砲台也稱『荷蘭城砲台』；白米甕砲台位於基隆港西邊，坐落在海拔近70公尺的高地上，高地的兩旁有小山，形成天然的屏障，為港口西岸的第一道防禦防線，目前白米甕砲台被列為國家三級古蹟。",
//                 imageUrl: "https://keelungfarm.klcg.gov.tw/Upload/FileManager/a4ec4317-7863-4ce8-9433-0c377d511d69.jpg",
//                 imageTitle: "白米甕砲台",
//                 link: ""),
//        Location(name: "基隆燈塔",
//                 cityName: "基隆",
//                 coordinates: CLLocationCoordinate2D(latitude: 25.15552, longitude: 121.74789),
//                 description: "西元1900年建造的基隆燈塔，位於基隆港西岸碼頭萬人堆鼻。原為磚砌圓塔，民國51年（西元1962年）改建為鋼筋混凝土圓塔。萬人堆鼻原是一岩石林立的海埔地，因周邊奇岩怪石林立，如眾多鼻頭堆疊羅列，因而得名，不過現今已改建為三十號碼頭。基隆燈塔早年還設有紅色光弧，以標示港外的險礁，頗為特殊，後因險礁遭炸除，紅色光弧也遭撤除。?基隆燈塔左邊的階梯跟圍牆內部沒有開放，只有開放右邊的步道通往觀海平台。",
//                 imageUrl: "https://keelungfarm.klcg.gov.tw/Upload/FileManager/684ce8d9-efb4-44d3-94d6-d236f0b5f1fe.jpg",
//                 imageTitle: "基隆燈塔",
//                 link: ""),
//        Location(name: "湖海灣",
//                 cityName: "基隆",
//                 coordinates: CLLocationCoordinate2D(latitude: 25.17104, longitude: 121.70819),
//                 description: "從外木山漁港至大武崙澳底漁村之間，長約4公里的湖海路，是基隆市轄區僅存最長的天然海岸。沿線並有多家的海產餐廳、咖啡館及行動遊客服務站，是一個適合闔家大小及青年朋友、情侶等前來遊玩的好去處。湖海灣海岸礁岩長年經海水沖蝕，雕塑出奇特的造型，遊客在此除可飽覽海天一色風光外，沿著自行車步道行走，還可遠眺基隆嶼，看大船入港，是休閒、健行的好去處。為服務遊客設置的遊客服務站，讓遊客一邊品啜咖啡茶飲，一邊聆聽濤聲，於傍晚時欣賞彩霞萬丈之景，更可欣賞海面上漁火點點，是值得深入觀賞體會的地點。",
//                 imageUrl: "https://keelungfarm.klcg.gov.tw/Upload/FileManager/a122e576-ef5c-4196-a59f-0ea2f981f47a.jpg",
//                 imageTitle: "湖海灣",
//                 link: ""),
//    ]

