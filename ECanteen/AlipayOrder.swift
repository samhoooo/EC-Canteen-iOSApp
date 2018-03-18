//
//  AlipayOrder.swift
//  ECanteen
//
//  Created by Sam on 18/3/2018.
//  Copyright © 2018年 jaar.ga. All rights reserved.
//

import Foundation

class AlipayOrder{
    let app_id = "2016091200491032"
    let notify_url = "www.cse.cuhk.edu.hk"
    let public_key =                 "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArkLHT0lCfv8+3ncm04PePoIW4s8dduZEbVO83+HU9cK2+bCLndqqtLFYRkkBLkTaYT4mVf95mcMj+PpXABmxKBhq9vVn8dkqzaRay7+8VgAXErYQeH5BlEWT0+jciFAqZFED2boSLqz/cjnC2DPdPEDuuxJTgpbf+sS6tkZyJ5HWi6JL5MkH8KWBcP4lqQ9UJWwpK/AIg3E3Xr2l+3TVGUg6nida5qYUgM25ON29DrbwdVMksh4LVtx2/Dt1WAJDB8fP3+RwWXsRlBYq9BS+d50bUgn0g3J5nhA0Wra5nZ1HF468nq9IQO5GHWW4qNO1L6nqzVTLFxUQNQUSCaegnwIDAQAB"
    let private_key = "MIIEpAIBAAKCAQEA1xCv+9sexo0Gbtf/AWKPnrrheltBD5AENHqVdkkvCqhfYtQ2bhiqPPZYt0/G7+9SCuDDrtnadD7hHuulIogzW2Ri8N6kwqnf9sTtQ6LgkCin7BUrtRSzhAmift7EgNfyukyTyqpaFggPzlnOLZl+EMT9yBWOir6OoreAELGdL8OBmYwmM8q/NnYrlQTFaE6cxnoprQmK9049ExOkYGBgZDYkQaJC+WPn/O4NsZ0iu7h0vpvIImMxmQxjU5+EEum16IEvhOp0MpEaRfCoN0OIofBvMXD9GuAXmLgaHOiFuOjaucfPJay31b91WQurUD9Yv5KN5yewdgeXVxL5iIn7YQIDAQABAoIBABumj5nIAFrywsL5jlW1QFXeHSNIHENN9txwbkr4+c1a/HiOZDkffrO70Igw/5jVoiy33TDb3ZRYiUUacu7PqBq1+2qQlYpZoOvvQboSdODT+VMHHcl4UeRGANhi98zA9vow4keKQ27VtoKHVVTTiTvKt/5Dl0ILYfdVtGdxDo6XTeRh0x/q0OmhFH1yZGqBrr2k0mV7axddheAv3WvZuD+jxnbiRbdNqqjKWDqBbpt19FY499RmG830hcUWaWbNLMq2ogDaEj0yn4BdkguQm6xZPg8xMqWoNE2doT4gD1K610VJVLwzJ7VmGPegLqVH6Xg6n5bUqTvveLo63fTVYAECgYEA930+AyPgLPjgoHCoDnyGHsbrz7TZ25uXsg9oXTeKe0VqkdSvHvfSr1g7rnE/NSth9a0NorP0Q4o6huz1RTgfbRPXwvfhVlZfXAZH9GvlPdxex5kuS211MTda8F3804E99K+xGC7NdyBBbkHhwRutLjEN95gQ8OdHZDcvLCncCIECgYEA3nYAfsNqdHPYzlTTRRUKBNrOk/16d+ra5zPc7y5zsmbM2EjVWRD1muKlVmou3NOWPogRF3mOGIe7FSqvZUgWbzy1MMZF+CXQf8DAJRXYc5OIOUtbATEg83M7DFfiuEUXbHI4cDAtGDkdGPauQFMeU6EMVxHkQEyOmIycCK9VguECgYEAiQ/UcxrAQUfH5zLc78Do6kySNiLbcHL4DQXZb56d0+06uu7F2Wm4RaGg09gmAEU5aDzhy1TMF0eLaEP9BcuyI8+Uc4aiRhVplGZqHSRP/fV4jCP6bo19FLeqZmo25c+yxzsx4cmxwqKbefuEklTIkUdbi96sqy367LZfKp84G4ECgYArA6YU3LQ40C2bt8siEG9fgO9wrhKAHWk2S1Ds7o5wcHArYenezuiuiiRuERn+mOr0LFshrt9K3vPNo/NGIio0WAiw5aWh1a37BcohYZf4wQ4WBfwSvu0gJafFOzkbaECfN3ayOp59kI2PxiLrTScQBJPeQhdgV207EfUZuM1QAQKBgQDPUilWnRY31wHpT52g7yImwgmkiU4kM2BRklgPOOMI8kLuEVOi/jXJc0YrCAfQgqazQLHytXbdiiY140otZD+pgNfTf+xDUi1SddThQB565VXLgUY7iwSHGeU30MqB156dFvZdhberHRTwQCZU7XZVsueIKaTRBQJYMnB0ueTCqQ==" //this should store in server side in actually implementation!!!


    
    //required field
    var subject:String;
    var out_trade_no:String;
    var total_amount:Double;
    var product_code:String;
    
    
    init (subject:String, out_trade_no:String, total_amount:Double, product_code:String) {
        self.subject = subject
        self.out_trade_no = out_trade_no
        self.total_amount = total_amount
        self.product_code = product_code
    }
    
    func getRequestString(){
        var requestString:String = ""
        
        let appid:String = "app_id="+self.app_id
        let method:String = "method=alipay.trade.app.pay"
        let notify_url:String = "notify_url="+self.notify_url
        let sign_type:String = "sign_type=RSA2"
        let charset:String = "charset=utf-8"
        let format:String = "format=json"
        let version:String = "version=1.0"
        let sign:String = "sign="+self.public_key
        
        let biz_content: [String: Any] = [
            "subject": self.subject,
            "out_trade_no": self.out_trade_no,
            "total_amount": String(self.total_amount/100),
            "product_code": self.product_code
        ]
        let jsonData = try! JSONSerialization.data(withJSONObject: biz_content)
        let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)
        
        requestString += appid+"&"
        requestString += method+"&"
        requestString += notify_url+"&"
        requestString += sign_type+"&"
        requestString += charset+"&"
        requestString += format+"&"
        requestString += version+"&"
        requestString += sign
        requestString += "&biz_content"+(jsonString as! String)
        
        let encodedRequestString = requestString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)

        print(encodedRequestString)
    }
}
