import http from '@ohos.net.http';

export default class httpSystem {
  public httpRequest
  public requestOptions
  private baseUrl:string = 'https://www.atihealthtech.com/prod-api/'

  constructor() {
    this.httpRequest = http.createHttp();

    this.requestOptions = {
      header:{
        'Content-Type':'application/json'
      },
      connectTimeout:30000,
      readTimeout:3000
    }
    this.httpRequest.on('headersReceive',(header)=>{
      console.info("header:"+JSON.stringify(header))
    })
  }

  public doPost<T>(url,params):Promise<T>{
    this.requestOptions.extraData = params
    this.requestOptions.method = http.RequestMethod.POST
    let res = this.httpRequest.request(`${this.baseUrl}${url}`,this.requestOptions)
    return new Promise((resolve,reject)=>{
      res.then((data)=>{
        if(data.responseCode === 200){
          console.info(data.result)
          resolve(JSON.parse(data.result))
        }
      }).catch((error)=>{
        reject(error)
        this.httpRequest.destroy()
      })
    })
  }
}