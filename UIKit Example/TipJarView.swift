//
//  TipJarView.swift
//  UIKit Example
//
//  Created by Daniel Kasaj on 16.04.2022..
//

import UIKit

class TipJarView: UIView {

    let stackView = UIStackView()

    let smallTipButton = UIButton(type: .system)
    let mediumTipButton = UIButton(type: .system)
    let largeTipButton = UIButton(type: .system)
    let hugeTipButton = UIButton(type: .system)

    var tipButtons: [UIButton] {
        return [smallTipButton, mediumTipButton, largeTipButton, hugeTipButton]
    }

    let thankYouLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        backgroundColor = .systemBackground
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 24

        thankYouLabel.text = "Thank you!"
        thankYouLabel.textColor = .label
        thankYouLabel.alpha = 0

        stackView.addArrangedSubview(smallTipButton)
        stackView.addArrangedSubview(mediumTipButton)
        stackView.addArrangedSubview(largeTipButton)
        stackView.addArrangedSubview(hugeTipButton)
        stackView.addArrangedSubview(thankYouLabel)

        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

}
