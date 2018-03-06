import WatchKit
import HealthKit

class InterfaceController: WKInterfaceController {
    @IBOutlet var workoutButton: WKInterfaceButton!
    
    private var session: HKWorkoutSession? = nil
    private var store: HKHealthStore = HKHealthStore()
    
    var workoutConfiguration: HKWorkoutConfiguration {
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = .americanFootball
        configuration.locationType = .unknown
        return configuration
    }
    
    @IBAction func handleWorkoutButton() {
        
        if let session = session {
            store.end(session)
            
        } else {
            
            do {
                session = try HKWorkoutSession(configuration: workoutConfiguration)
                session!.delegate = self
                store.start(session!)
            } catch let error {
                print(error.localizedDescription)
            }
            
        }
        
    }

    @IBAction func playHaptic() {
        WKInterfaceDevice.current().play(.stop)
    }
    
    @IBAction func playHapticDelay() {
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
            WKInterfaceDevice.current().play(.stop)
        }
    }
    
}

extension InterfaceController: HKWorkoutSessionDelegate {
    func workoutSession(_ workoutSession: HKWorkoutSession, didChangeTo toState: HKWorkoutSessionState, from fromState: HKWorkoutSessionState, date: Date) {
        switch toState {
        case .running:
            session = workoutSession
            WKExtension.shared().isFrontmostTimeoutExtended = true
            DispatchQueue.main.async {
                self.workoutButton.setTitle("End Workout")
            }
            
        case .ended:
            session = nil
            WKExtension.shared().isFrontmostTimeoutExtended = false
            DispatchQueue.main.async {
                self.workoutButton.setTitle("Start Workout")
            }
            
        default: break
        }
    }
    
    func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

