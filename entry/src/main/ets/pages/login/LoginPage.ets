import hilog from '@ohos.hilog';
import { loginApi, sendCodeApi } from '../../api/login'
import { uuid } from '../../common/utils/common/utils'
import PreferencesUtils from '../../common/utils/common/PrefUtil'

@Entry
@Component
struct LoginPage {
	@State phone: string = ''
	@State msgCode: string = ''
	@State step: number = 1

	async sendCode() {
		const res: any = await sendCodeApi({
			userType: '22',
			username: this.phone,
			sendEntry: 'REGISTER_AND_LOGIN'
		});
		if (res.code === 200) {
			this.step = 2
		}
	}

	async login() {
		const res: any = await loginApi({
			username: this.phone,
			msgCode: this.msgCode,
			uuid: uuid(),
			userType: '22',
			sendEntry: 'REGISTER_AND_LOGIN'
		})
		if (res.code === 200) {
			PreferencesUtils.put('token', res.data.access_token)
		}
	}

	build() {
		Column() {
			Image($r('app.media.login_bg'))
				.width('100%')

			if (this.step === 1) {
				Column() {
					Text("手机号登录/注册")
						.textAlign(TextAlign.Start)
						.width('100%')
						.fontColor('#000000')
						.fontWeight(500)

					TextInput({ placeholder: '请输入您的手机号' })
						.margin({ bottom: lpx2px(24) + 'px', top: lpx2px(12) + 'px' })
						.type(InputType.PhoneNumber)
						.onChange((value: string) => {
							this.phone = value
						})
					Button('获取验证码', { type: ButtonType.Normal, stateEffect: true })
						.borderRadius(8)
						.backgroundColor(0x317aff)
						.width('100%')
						.onClick(() => {
							this.sendCode()
						})
				}
				.padding(lpx2px(16) + "px")
				.backgroundColor('#FFFFFF')
				.margin({ top: '-' + lpx2px(77) + 'px' })
				.borderRadius({ topLeft: lpx2px(20) + 'px', topRight: lpx2px(20) + 'px' })
				.justifyContent(FlexAlign.Start)

				Blank()
				Row() {
					Radio({ value: '1', group: '1' })
					Text('我已阅读并同意')
						.fontSize(lpx2px(12) + 'px')
					Text('《用户协议及隐私政策》')
						.fontSize(lpx2px(12) + 'px')
						.fontColor('#1B6AFE')
				}
				.margin({ bottom: lpx2px(32) + 'px' })
			}
			if (this.step === 2) {
				Column() {
					Text("输入短信验证码")
						.textAlign(TextAlign.Start)
						.width('100%')
						.fontColor('#000000')
						.fontWeight(500)

					Row() {
						TextInput({ placeholder: '请输入短信验证码' })
							.onChange((value: string) => {
								this.msgCode = value
							})
							.layoutWeight(1)
						Text('重新发送')
							.fontColor('#1B6AFE')
							.margin({left:lpx2px(16)+'px'})
					}
					.alignItems(VerticalAlign.Center)
					.margin({ bottom: lpx2px(24) + 'px', top: lpx2px(12) + 'px' })



					Button('登录', { type: ButtonType.Normal, stateEffect: true })
						.borderRadius(8)
						.backgroundColor(0x317aff)
						.width('100%')
						.onClick(() => {
							this.login()
						})
				}
				.padding(lpx2px(16) + "px")
				.backgroundColor('#FFFFFF')
				.margin({ top: '-' + lpx2px(77) + 'px' })
				.borderRadius({ topLeft: lpx2px(20) + 'px', topRight: lpx2px(20) + 'px' })
				.justifyContent(FlexAlign.Start)

			}
		}
		.height('100%')
	}
}