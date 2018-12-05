//
//  SunriseAndSunsetViewController.swift
//  TeamvoyTestApp
//
//  Created by Alex on 04.12.18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit

final class SunriseAndSunsetViewController: UIViewController {
    
    @IBOutlet private weak var dayLenghtLabel: UILabel!
    @IBOutlet private weak var civilTwilightBeginLabel: UILabel!
    @IBOutlet private weak var sunriseLabel: UILabel!
    @IBOutlet private weak var sunsetLabel: UILabel!
    @IBOutlet private weak var nauticalTwilightBeginLabel: UILabel!
    @IBOutlet private weak var civilTwilightEndLabel: UILabel!
    @IBOutlet private weak var solarNoonLabel: UILabel!
    @IBOutlet private weak var astronomicalTwilightEndLabel: UILabel!
    @IBOutlet private weak var astronomicalTwilightBeginLabel: UILabel!
    @IBOutlet private weak var nauticalTwilightEndLabel: UILabel!
    
    private let presenter = SunrisePresenter()
    private let defaultText = "No info"
    
    var place: Place!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        presenter.fetchSunriceFor(place: place)
        configureNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension SunriseAndSunsetViewController: SunriseView {
    func update(with data: SunriseSunsetResponse.SunriseSunset) {
       
        sunriseLabel.text                   = data.sunrise?.UTCToLocal() ?? defaultText
        sunsetLabel.text                    = data.sunset?.UTCToLocal() ?? defaultText
        dayLenghtLabel.text                 = data.dayLength?.UTCToLocal() ?? defaultText
        civilTwilightEndLabel.text          = data.civilTwilightEnd?.UTCToLocal() ?? defaultText
        civilTwilightBeginLabel.text        = data.civilTwilightBegin?.UTCToLocal() ?? defaultText
        solarNoonLabel.text                 = data.solarNoon?.UTCToLocal() ?? defaultText
        nauticalTwilightEndLabel.text       = data.nauticalTwilightEnd?.UTCToLocal() ?? defaultText
        nauticalTwilightBeginLabel.text     = data.nauticalTwilightBegin?.UTCToLocal() ?? defaultText
        astronomicalTwilightEndLabel.text   = data.astronomicalTwilightEnd?.UTCToLocal() ?? defaultText
        astronomicalTwilightBeginLabel.text = data.astronomicalTwilightBegin?.UTCToLocal() ?? defaultText
    }
}

private extension SunriseAndSunsetViewController {
    func configureNavigationBar() {
        title = place.name
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.transparentNavigationBar()
    }
}
