#Shift::
{
    SysGet, MonitorCount, MonitorCount
    if (MonitorCount > 1) {
        WinGet, id, list
        Loop, %id%
        {
            this_id := id%A_Index%
            WinGetPos, this_x, this_y, this_width, this_height, ahk_id %this_id%
            ; 適宜自分の環境に合わせて調整する
            ; 以下のコメントを外してパラメータの値を確認する
            ; MsgBox, window ID: %this_id%, x: %this_x%, y: %this_y%, width: %this_width%, height: %this_height%
            if (this_x > -10 and this_x < 0 and this_y > -10 and this_y < 0) {
                right_id := this_id
                break
            }
        }
        Loop, %id%
        {
            this_id := id%A_Index%
            WinGetPos, this_x, this_y, this_width, this_height, ahk_id %this_id%
            if (this_x < -1920 and this_x > -1930 and this_y > -10 and this_y < 0 and this_width > 1920 and this_height > 1080) {
                left_id := this_id
                break
            }
        }
        if (right_id) {
            WinGet, right_process, ProcessName, ahk_id %right_id%
            ; なぜかわからないけど、WinMoveを2回呼ぶと最大化できる
            WinMove, ahk_id %right_id%, , -1500, 100, 1000, 500
            WinMove, ahk_id %right_id%, , -1500, 100, 1000, 500
        }
        if (left_id) {
            WinGet, left_process, ProcessName, ahk_id %left_id%
            WinMove, ahk_id %left_id%, , 100, 100, 1000, 500
            WinMove, ahk_id %left_id%, , 100, 100, 1000, 500
        }
    }
}

; 以下メモ
; A_ScreenWidth ; スクリーンの幅
; A_ScreenHeight ; スクリーンの高さ
; active_id := WinGetID("A") ; アクティブなウィンドウのIDを取得
; WinRestore, ahk_id %right_id% ; 最大化を解除？
;                                 WinMoveのあとにWinMaximizeを呼んでも最大化されなかったため使用した
;                                 しかし、これを呼ぶと移動が取り消された（なぜ？）
; WinMaximize, ahk_id %right_id% ; 最大化