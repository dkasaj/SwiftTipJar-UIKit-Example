//
//  ViewController.swift
//  UIKit Example
//
//  Created by Daniel Kasaj on 16.04.2022..
//

import UIKit
import SwiftTipJar

class ViewController: UIViewController {

    let tipJar = SwiftTipJar(tipsIdentifiers: Set([
        "com.test.smallTip",
        "com.test.mediumTip",
        "com.test.largeTip",
        "com.test.hugeTip"
    ]))

    let tipJarView = TipJarView()

    // MARK: - Lifecycle

    override func loadView() {
        view = tipJarView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tipJar.startObservingPaymentQueue()

        // Set up what happens when tipJar learns about App Store Connect or StoreKit Configuration products
        tipJar.productsReceivedBlock = setupButtons
        tipJar.transactionSuccessfulBlock = showThankYou

        // Start learning about App Store Connect or StoreKit Configuration products
        tipJar.productsRequest?.start()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tipJar.stopObservingPaymentQueue()
    }

    // MARK: - Actions

    @objc func userDidTapButton(_ sender: UIButton?) {
        guard let identifier = sender?.accessibilityIdentifier else { return }
        tipJar.initiatePurchase(productIdentifier: identifier)
    }

    // MARK: - Blocks

    private func setupButtons() {
        // Must run on main thread because it will be called from background but is setting up UI elements
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            for index in self.tipJar.tips.indices {
                let button = self.tipJarView.tipButtons[index]
                let tip = self.tipJar.tips[index]
                button.setTitle(tip.displayName + " " + tip.displayPrice, for: .normal)
                button.accessibilityIdentifier = tip.identifier
                button.addTarget(self, action: #selector(self.userDidTapButton(_:)), for: .touchUpInside)
            }

        }
    }

    private func showThankYou() {
        // Must run on main thread because it will be called from background but is setting up UI elements
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tipJarView.thankYouLabel.alpha = 1
        }
    }
}

