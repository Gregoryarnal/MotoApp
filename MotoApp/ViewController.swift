import UIKit
import CoreMotion

class ViewController: UIViewController {

    let motionManager = CMMotionManager()
    @IBOutlet weak var angleLabel: UILabel!
//    @IBOutlet weak var angleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.2
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
                if let accelerometerData = data {
                    let acceleration = accelerometerData.acceleration
                    print("Acceleration: x = \(acceleration.x), y = \(acceleration.y), z = \(acceleration.z)")
                }
            }
        }
        
        if motionManager.isGyroAvailable {
            motionManager.gyroUpdateInterval = 0.2
            motionManager.startGyroUpdates(to: OperationQueue.current!) { (data, error) in
                if let gyroData = data {
                    let rotationRate = gyroData.rotationRate
                    //print("Rotation Rate: x = \(rotationRate.x), y = \(rotationRate.y), z = \(rotationRate.z)")
                }
            }
        }
        
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.5
            motionManager.startDeviceMotionUpdates(to: OperationQueue.current!) { (data, error) in
                if let deviceMotion = data {
                    let attitude = deviceMotion.attitude
                    let gravity = deviceMotion.gravity
                    let userAcceleration = deviceMotion.userAcceleration

                    let rotation = atan2(gravity.x,gravity.z) - .pi / 2.0
                    var degrees = rotation * (180.0 / .pi)

                    let textLabeltxtBof = "Même ma grand mère penche plus !"
                    let textLabeltxtBien = "Pas mal !"
                    let textLabeltxtTop = "On t'a volé ta moto, y'a quelqu'un qui sait conduire dessus !!!"
                    
                    if (degrees < 0){
                        degrees = 90 - (270+degrees)
                    }
                   
                    if (degrees >= 0){
                        degrees = -(degrees - 90)
                    }
                    
                    if(degrees < 25){
                        self.textLabel.text = textLabeltxtBof
                    }else if (degrees >= 25 && degrees < 45){
                        self.textLabel.text = textLabeltxtBien
                    }else if (degrees >= 45){
                        self.textLabel.text = textLabeltxtTop
                    }
                    
                   
                    self.angleLabel.text = "Angle \(round( degrees * 100) / 100.0) degrés"
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
