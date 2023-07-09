//
//  BaseViewController.swift
//  Spy See
//
//  Created by 楊哲維 on 2023/6/24.
//

import UIKit
import SnapKit
import IQKeyboardManager
import AudioToolbox
import AVFoundation

class BaseViewController: UIViewController {
    var isEnableIQKeyboard: Bool {
        return true
    }
    lazy var backgroundImageView: UIImageView =  {
        let backgroundImageView = UIImageView()
        backgroundImageView.image = .asset(.background)
        return backgroundImageView
    }()
    var seAudioPlayer: AVAudioPlayer?
    let clickUrl = Bundle.main.url(forResource: "click_se", withExtension: "wav")
    let editingUrl = Bundle.main.url(forResource: "editing_se", withExtension: "wav")
    let playUrl = Bundle.main.url(forResource: "play_se", withExtension: "wav")
    override func viewDidLoad() {
        super.viewDidLoad()
        configBackground()
        navigationItem.setHidesBackButton(true, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared().isEnabled = isEnableIQKeyboard
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
        setNeedsStatusBarAppearanceUpdate()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared().isEnabled = !isEnableIQKeyboard
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
    }
    private func configBackground() {
        view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalTo(view).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
    func vibrate() {
        let vibrateGenerator = UIImpactFeedbackGenerator(style: .heavy)
        vibrateGenerator.prepare()
        vibrateGenerator.impactOccurred()
    }
    func vibrateHard() {
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
    func playSeAudio(from url: URL) {
        do {
            seAudioPlayer = try AVAudioPlayer(contentsOf: url)
            seAudioPlayer?.prepareToPlay()
            seAudioPlayer?.play()
        } catch {
            print("Failed to play audio: \(error.localizedDescription)")
        }
    }
}
