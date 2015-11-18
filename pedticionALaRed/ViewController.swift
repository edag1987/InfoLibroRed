//
//  ViewController.swift
//  pedticionALaRed
//
//  Created by Danilo Adriano Gallardo on 17/11/15.
//  Copyright © 2015 Danilo Adriano Gallardo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //prueba github

    @IBOutlet weak var tftexto: UITextField!
    @IBOutlet weak var tvPantalla: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func sincrono(){
        let isbt = tftexto.text
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:\(isbt!)"
        let url = NSURL(string: urls)
        let datos:NSData? = NSData(contentsOfURL: url!)//agregamos "!" al url ya que al modificar la direccion se nos hace opcional
        if datos == nil{
            let alerta = UIAlertController(title: "Alerta", message: "No dispone de servicio de internet", preferredStyle: .Alert)
            alerta.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            self.presentViewController(alerta, animated: true, completion: nil)
        }else{
            let texto = NSString(data: datos!, encoding: NSUTF8StringEncoding)
            tvPantalla.text = String(texto)
        }
    }

    @IBAction func serchTextField(sender: UITextField) {
        if tftexto.text == "" {
            let alerta = UIAlertController(title: "Alerta", message: "Ingrese un numero", preferredStyle: .Alert)
            alerta.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            self.presentViewController(alerta, animated: true, completion: nil)
        } else{
            sincrono()
            sender.resignFirstResponder()
        }
    }
    
    @IBAction func deseparecerTeclado(sender: AnyObject) {
        tftexto.resignFirstResponder()
        tvPantalla.resignFirstResponder()
    }
    
    @IBAction func limpiar(sender: UIButton) {
        tftexto.text = String()
        tvPantalla.text = String()
    }
}










