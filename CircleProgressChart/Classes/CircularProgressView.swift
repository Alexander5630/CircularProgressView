public class CircularProgressView: UIView {
    
    public var circleColor: UIColor = #colorLiteral(red: 0.7999292612, green: 0.8000453115, blue: 0.7999040484, alpha: 1) {
        didSet {
            circleLayer.strokeColor = circleColor.cgColor
        }
    }
    
    public var progressColor: UIColor =  #colorLiteral(red: 0.07347138971, green: 0.5590900779, blue: 0.8216868043, alpha: 1) {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
        }
    }
    
    public var hideCenterPercentage: Bool = false {
        didSet {
            self.addSubview(percentageView)
        }
    }
    
    public var percentage: CGFloat = 0.0 {
        didSet {
            percentageLabel.text = String(format: "%.2f", (percentage * 100)) + "%"
            progressAnimation()
        }
    }
    
    private var radius: CGFloat = 60.0
    
    
    private lazy var circleLayer: CAShapeLayer = {
        let shape = CAShapeLayer()
        shape.fillColor = UIColor.clear.cgColor
        shape.lineCap = "round"
        shape.lineWidth = 10.0
        shape.strokeColor = #colorLiteral(red: 0.7999292612, green: 0.8000453115, blue: 0.7999040484, alpha: 1)
        return shape
    }()
    
    private lazy var progressLayer: CAShapeLayer = {
        let progress = CAShapeLayer()
        progress.fillColor = UIColor.clear.cgColor
         progress.lineCap = "round"
        progress.lineWidth = 10.0
        progress.strokeEnd = 0
        progress.strokeColor = #colorLiteral(red: 0.07347138971, green: 0.5590900779, blue: 0.8216868043, alpha: 1)
        return progress
    }()
    
    private var percentageLabel = UILabel()
    
    private lazy var percentageView: UIView = {
        let x = ((frame.size.width / 2.0) - (radius))
        let y = ((frame.size.height / 2.0) - (radius))
        let view = UIView(frame: CGRect(x: x,
                                        y: y,
                                        width: radius * 2,
                                        height: radius * 2))
        percentageLabel.frame = CGRect(x: 0,
                                       y: 0,
                                       width: view.frame.width,
                                       height: view.frame.height)
        percentageLabel.textAlignment = .center
        percentageLabel.font = UIFont.boldSystemFont(ofSize: 30)
        view.addSubview(percentageLabel)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func createCircularPath(percentage: CGFloat, radius: CGFloat) {
        self.radius = radius
        self.percentage = percentage
        updatePath()
        layer.addSublayer(circleLayer)
        layer.addSublayer(progressLayer)
        progressAnimation()
    }
    
    public override func layoutSubviews() {
        updatePath()
    }
    
    private func updatePath() {
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: radius, startAngle: .pi / 2, endAngle: 2.5 * .pi, clockwise: true)
        
        circleLayer.path = circularPath.cgPath
        progressLayer.path = circularPath.cgPath
    }
    
    private func hideCenterPercentage(_ hidePercentage: Bool) {
        self.addSubview(percentageView)
    }
    
}
public extension CircularProgressView {
    private func progressAnimation() {
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProgressAnimation.duration = 1
        circularProgressAnimation.toValue = Float(percentage)
        circularProgressAnimation.fillMode = "forwards"
        circularProgressAnimation.isRemovedOnCompletion = false
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
    }
}
