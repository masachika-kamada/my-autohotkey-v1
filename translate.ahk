; Ctrl+Shift+X 押下時のスクリプト
;
; ^+x (=Ctrl+Shift+X) を任意のキーバインドに変更できます
; 例えば Ctrl+Shift+Alt+D なら ^+!d です
;
; Ctrl = ^
; Shift = +
; Alt = !
; Windows = #
^+x::
    ; ウィンドウ遷移やキー操作の待機時間(msec)
    ; 上手く機能しないときはこの値を大きくしてください
    wait_time = 50

    ; 現在アクティブのウィンドウ（PDF viewer）のIDを取得
    WinGet main_id, ID, A

    ; 改ページや図表で分断された段落を一度に翻訳するためには
    ; 前半部分を先に Ctrl+C でコピーしておき、後半部分を
    ; 選択状態にして Ctrl+Shift+Z を実行してください。

    first_half = %clipboard% ; Clipboardにテキストがあれば保存
    Send, ^c ; 選択部分をコピー
    Sleep %wait_time%
    if StrLen(first_half) > 0
        target_str = %first_half% %clipboard% ; 文字列を結合
    Else
        target_str = %clipboard%

    ; 改行コードをすべて空白に置換
    StringReplace, replaced_str, target_str, `r`n, %A_Space%, All
    clipboard = %replaced_str% ; クリップボードに代入

    ; 'DeepL...' というtitleのウィンドウを探します（前方一致）
    ; ウィンドウが存在しない場合、エラーメッセージを表示
    IfWinNotExist, DeepL
    {
        MsgBox, , , DeepL window not found.`r`nPlease keep DeepL open first!
        clipboard = ; クリップボードを空にして終了
        return
    }

    ; 予め開いておいたDeepL翻訳ウィンドウをアクティブに
    WinActivate, DeepL
    ; アクティブになるまで待機
    WinWaitActive, DeepL, , 2

    Send, ^a ; 原文のテキストフィールドを選択
    Send, ^v ; 置換されたテキストを貼り付け
    Sleep %wait_time%

    WinActivate, ahk_id %main_id% ;PDF viewerをアクティブに戻す
    Sleep %wait_time%
    clipboard = ; 毎回クリップボードを空にしておく
return