import promptAction from '@ohos.promptAction'

export function showToast(message: string): void {
  promptAction.showToast({
    message: message
  })
}
