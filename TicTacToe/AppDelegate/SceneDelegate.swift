import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate
{
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions)
    {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let interfaceColor = scoreBackGroundColor
        
        let navigationController = UINavigationController(rootViewController: TicTacToeViewController())
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: interfaceColor]
        
        window?.tintColor = interfaceColor
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
