import httpSystem from '../common/utils/http/HttpSystem'

let myHttpSystem = new httpSystem()

export const loginApi = (params:any) =>{
  return myHttpSystem.doPost('auth/appLogin', params)
}

export const sendCodeApi = (params : { username : string, userType : string, sendEntry : string }) => {
  return myHttpSystem.doPost('/auth/sendCode', params)
}
