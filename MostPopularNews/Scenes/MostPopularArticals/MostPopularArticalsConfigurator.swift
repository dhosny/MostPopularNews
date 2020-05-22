
import UIKit

enum MostPopularArticalsConfigurator {
    
    case MostPopularArticalsVC

    var viewController: UIViewController {
        switch self {
        case .MostPopularArticalsVC:
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MostPopularArticalsVC") as! MostPopularArticalsViewController
            let getway: ArticalsGateway = ArticalsGatewayImp()
            vc.presenter = MostPopularArticalsPresenterImp(view: vc as MostPopularArticalsView, articalGateway: getway)
            return vc
        }
    }
}
