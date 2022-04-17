enum GameRole: String
{
    case zero = "🐱"
    case cross = "🐶"
    
    mutating func toggle()
    {
        if self == .zero
        {
            self = .cross
        }
        else
        {
            self = .zero
        }
    }
}
