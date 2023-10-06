//
//  VideoView.swift
//  K-AGScore
//
//  Created by MARY on 2023/10/06.
//

import AVKit

final class VideoView: UIView {
    let videoView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        self.addSubview(videoView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            videoView.topAnchor.constraint(equalTo: self.topAnchor),
            videoView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            videoView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            videoView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    func playVideo() {
        guard let path = Bundle.main.path(forResource: "HangzhouVideo", ofType: "mp4") else {
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = videoView.bounds
        videoView.layer.addSublayer(playerLayer)
        playerLayer.videoGravity = .resizeAspectFill
//        player.isMuted = true
        player.play()
    }
}
