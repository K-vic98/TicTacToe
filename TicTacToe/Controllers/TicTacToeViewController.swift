import UIKit

final class TicTacToeViewController: UIViewController
{
    private let playGround = PlayGround()
    private let ticTacToeView = TicTacToeView()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.addSubview(ticTacToeView)
        ticTacToeView.edgesToSuperview()
        ticTacToeView.cellClickHandler = self
        
        title = "Tic Tac Toe"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(restartPressed))
        
        updateScore()
    }
    
    @objc private func restartPressed()
    {
        ticTacToeView.clearCells()
        playGround.clear()
    }
    
    private func showWiner(_ winer: String)
    {
        let victoryAlertController = UIAlertController(title: "🏆", message: "\(winer) won", preferredStyle: .alert)
        
        let restartAction = UIAlertAction(title: "Restart", style: .default)
        { [weak self] _ in
            self?.restartPressed()
            self?.updateScore()
        }
        restartAction.setValue(UIColor.black, forKey: "titleTextColor")
        
        victoryAlertController.addAction(restartAction)
        self.present(victoryAlertController, animated: true)
    }
    
    private func updateScore()
    {
        ticTacToeView.changeScores(zero: String(playGround.zeroesScore), cross: String(playGround.crossesScore))
    }
}

protocol CellClickHandler: AnyObject
{
    func  handleCellClick(cellIndex: Int)
}

extension TicTacToeViewController: CellClickHandler
{
    func handleCellClick(cellIndex: Int)
    {
        let currentPlayer = playGround.currentPlayer.rawValue
        
        playGround.fixateCell(index: cellIndex)
        ticTacToeView.updateCell(cellIndex: cellIndex, state: currentPlayer)
        
        if playGround.сheckWin() != nil
        {
            showWiner(currentPlayer)
            playGround.increaseScoreCount()
        }
        else if playGround.checkGameOver()
        {
            showWiner("Nobody")
        }
        
        playGround.toggleCurrentState()
    }
}
