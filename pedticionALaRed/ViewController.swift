// xx
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
    @IBOutlet weak var lbtitulo: UILabel!
    @IBOutlet weak var lbAutor: UILabel!
    @IBOutlet weak var portada: UIImageView!
    
    override func viewDidLoad() {
        lbtitulo.text = String()
        lbAutor.text = String()
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
        }
        else{
            let texto = NSString(data: datos!, encoding: NSUTF8StringEncoding)
            if texto == "{}"{
                let alerta = UIAlertController(title: "Alerta", message: "Libro no existente", preferredStyle: .Alert)
                alerta.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                self.presentViewController(alerta, animated: true, completion: nil)
            }else{
            //tvPantalla.text = String(texto) //funcion que imprime el json no funcional
            do{
                let jsonCompleto = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableContainers)
                let capa1 = jsonCompleto as! NSDictionary
                let capa2 = capa1["ISBN:" + isbt!] as! NSDictionary
                lbtitulo.text = capa2["title"] as! NSString as String
                let capa3 = capa2["authors"] as! NSArray
                ///////////////////////////////////////////////////////////////////////////////
                capa3.enumerateObjectsUsingBlock({ objeto, index, stop in
                    let capa4 = objeto["name"] as! String
                    self.lbAutor.text = capa4
                })// al estar en un array se recorre con el metodo ".enumerateObjectsUsingBlock"
                ///////////////////////////////////////////////////////////////////////////////
                tvPantalla.text = String(capa2)
                
                
                let capa5 = capa2["cover"] as? NSDictionary
                if capa5 != nil{
                    let capa6 = capa5!["medium"] as! String
                    ///////////////////////////////////////////////////
                    portada.alpha = 1
                    let urls = capa6
                    let url = NSURL(string:urls)
                    let dataFoto = NSData(contentsOfURL: url!)
                    let fotoRed = UIImage(data: dataFoto!)
                    portada.image = fotoRed // subir foto de la internet
                    ///////////////////////////////////////////////////
                }else{
                    ////////////////////////////////////////////////////
                    portada.alpha = 1
                    let foto = UIImage(named: "IMG_7597")
                    portada.image = foto // agrego una foto a un Image View
                    ////////////////////////////////////////////////////
                }
                
            } catch{
                print("error al serializar")
            } // funcion desde "do" a "catch" que imprime todo el json funcional
        }
        }}

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
        lbtitulo.text = String()
        lbAutor.text = String()
        portada.alpha = 0
    }
    
    @IBAction func copiarNumero(sender: UIButton) {
        tftexto.text = "8497364678"
        sincrono()
    }
    
}










