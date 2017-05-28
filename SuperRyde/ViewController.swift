//
//  ViewController.swift
//  SuperRyde
//
//  Created by Warren Smith on 5/27/17.
//  Copyright © 2017 Warren Smith. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let headers: HTTPHeaders = [
            "Authorization": "Token jgLiCncpw6g1bopAahrf3R9LaN2MBIh124Tg6XdG",
            "Accept-Language": "en_US",
            "Content-Type": "application/json"
        ]

        Alamofire.request("https://api.uber.com/v1.2/estimates/price?start_latitude=37.7752315"
            + "&start_longitude=-122.418075"
            + "&end_latitude=37.7752415"
            + "&end_longitude=-122.518075", headers:headers).responseJSON { response in
            print(response.request)
            print(response.response)
            print(response.data)
            print(response.result)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

