import UIKit
import TinyConstraints

final class TicTacToeView : UIView
{
    private let zeroScore = UILabel()
    private let crossScore = UILabel()
    private var cells: [UIButton] = []
    
    weak var cellClickHandler: CellClickHandler?
    
    init()
    {
        super.init(frame: CGRect())
        
        backgroundColor = ticTacToeBackgroundColor
        
        let playGroundView = makePlayGroundView()
        let scoreView = makeScoreView()
        
        self.addSubview(playGroundView)
        self.addSubview(scoreView)
        
        playGroundView.edgesToSuperview(insets: TinyEdgeInsets(top: 250, left: 20, bottom: 20, right: 20), usingSafeArea: true)
        
        scoreView.edgesToSuperview(excluding: .bottom, insets: .left(20) + .right(20) + .top(20), usingSafeArea: true)
        scoreView.bottomToTop(of: playGroundView, offset: -40)
        
        for cell in cells
        {
            cell.addTarget(self, action: #selector(cellPressed(cell:)), for: .touchDown)
        }
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View update
    
    @objc private func cellPressed(cell: UIButton?)
    {
        guard let safeCell = cell else
        {
            return
        }
        
        cellClickHandler?.handleCellClick(cellIndex: safeCell.tag)
    }
    
    func updateCell(cellIndex: Int, state: String)
    {
        cells[cellIndex].setTitle(state, for: .normal)
        cells[cellIndex].isEnabled = false
    }
    
    func clearCells()
    {
        for cell in cells
        {
            cell.setTitle("", for: .normal)
            cell.isEnabled = true
        }
    }
    
    func changeScores(zero: String, cross: String)
    {
        zeroScore.text = zero
        crossScore.text = cross
    }
    
    // MARK: - Custom views creation
    
    private func makePlayGroundView() -> UIStackView
    {
        let playGround = UIStackView()
        
        playGround.axis = .vertical
        playGround.distribution = .fillEqually
        playGround.spacing = 0
        
        var cellIndex = 0
        
        for _ in 0...2
        {
            let playGroundLine = UIStackView()
            
            playGroundLine.axis = .horizontal
            playGroundLine.distribution = .fillEqually
            playGroundLine.spacing = 0
            
            for _ in 0...2
            {
                let cell = UIButton()
                
                cell.setTitle("", for: .normal)
                cell.setTitleColor(ticTacToeTextColor, for: .normal)
                cell.titleLabel?.font = .systemFont(ofSize: 80, weight: .regular)
                cell.backgroundColor = cellBackgroundColor
                cell.layer.borderWidth = 8
                cell.layer.borderColor = ticTacToeBorderColor
                cell.tag = cellIndex
                
                cellIndex += 1
                
                cells.append(cell)
                
                playGroundLine.addArrangedSubview(cell)
            }
            
            playGround.addArrangedSubview(playGroundLine)
        }
        
        return playGround
    }
    
    private func makeScoreView() -> UIStackView
    {
        let scoreView = UIStackView()
        
        scoreView.axis = .horizontal
        scoreView.distribution = .fillEqually
        scoreView.spacing = 15
        
        var gameRole = GameRole.cross
        
        for _ in 0...1
        {
            let playerScore = UIStackView()
            
            playerScore.axis = .vertical
            playerScore.alignment = .center
            playerScore.distribution = .fillEqually
            playerScore.spacing = 5
            playerScore.backgroundColor = scoreBackGroundColor
            playerScore.layer.cornerRadius = 20
            playerScore.layer.borderWidth = 5
            playerScore.layer.borderColor = ticTacToeBorderColor
            
            let roleLabel = UILabel()
            roleLabel.text = gameRole.rawValue
            roleLabel.textColor = ticTacToeTextColor
            roleLabel.font = .systemFont(ofSize: 90, weight: .regular)
            
            playerScore.addArrangedSubview(roleLabel)
            
            if gameRole == .cross
            {
                crossScore.textColor = ticTacToeTextColor
                crossScore.font = .systemFont(ofSize: 80, weight: .regular)
                playerScore.addArrangedSubview(crossScore)
            }
            else
            {
                zeroScore.textColor = ticTacToeTextColor
                zeroScore.font = .systemFont(ofSize: 80, weight: .regular)
                playerScore.addArrangedSubview(zeroScore)
            }
            
            scoreView.addArrangedSubview(playerScore)
            
            gameRole.toggle()
        }
        
        return scoreView
    }
}
