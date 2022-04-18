import UIKit

fileprivate let cellCount = 9
fileprivate let combinations =
[
    Set([0, 1, 2]),
    Set([3, 4, 5]),
    Set([6, 7, 8]),
    Set([0, 3, 6]),
    Set([1, 4, 7]),
    Set([2, 5, 8]),
    Set([0, 4, 8]),
    Set([2, 4, 6])
]

final class PlayGround
{
    private var crosses = Set<Int>()
    private var zeroes = Set<Int>()
    
    private(set) var crossesScore = 0
    private(set) var zeroesScore = 0
    private(set) var currentPlayer = GameRole.zero
    
    func toggleCurrentState()
    {
        currentPlayer.toggle()
    }
    
    func increaseScoreCount()
    {
        if currentPlayer == .cross
        {
            crossesScore += 1
        }
        else
        {
            zeroesScore += 1
        }
    }
    
    func fixateCell(index: Int)
    {
        if currentPlayer == .cross
        {
            crosses.insert(index)
        }
        else if currentPlayer == .zero
        {
            zeroes.insert(index)
        }
    }
    
    func clear()
    {
        crosses.removeAll()
        zeroes.removeAll()
    }
    
    func сheckWin() -> GameRole?
    {
        var winner: GameRole?
        
        for combination in combinations
        {
            if combination.isSubset(of: crosses)
            {
                winner = GameRole.cross
                break
            }
            else if combination.isSubset(of: zeroes)
            {
                winner = GameRole.zero
                break
            }
        }
        
        return winner
    }
    
    func checkGameOver() -> Bool
    {
        guard crosses.count + zeroes.count == cellCount else
        {
            return false
        }
        
        return true
    }
}
