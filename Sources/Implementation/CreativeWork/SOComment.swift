import Foundation

public class SOComment: SOCreativeWork, Comment {
    override public class var type: String {
        return "Comment"
    }
    
    public var downvoteCount: Int?
    public var parentItem: Question?
    public var upvoteCount: Int?
}
