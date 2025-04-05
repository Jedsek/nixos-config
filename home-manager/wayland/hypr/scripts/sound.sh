#!/usr/bin/env bash

sound_dir=~/.config/hypr/sounds/妹红

message=""
path=""
timeout=""

case $1 in  
    "--low-battery")  
        message="电池电量低下了\n(电量30%)"
        path="09.电池不足警告.wav"
        timeout="1800"
        ;;  
    "--very-low-battery")  
        message="所以我就说了吧......\n(电量15%)"
        path="08.电池严重短缺警告.wav"
        timeout="2200"
        ;;  
    "--shutdown")  
        message="完事了呢，下次再见吧"  
        path="02.关机.wav"
        timeout="2800"
    ;;  
    "--startup")  
        message="成功启动了呢，辛苦你了"
        path="01.开机.wav"
        timeout="2700"
        ;;  
    "--sleep")  
        message="现在不在，留守中......\n之后再过来吧"  
        path="15.休眠.wav"
        timeout="3850"
        ;;  
    # "--change-theme")  
    #     message="清爽多了！"  
    #     path="04.win更换主题.wav"
    #     timeout="1350"
    #     ;;  
    "--default"|"--change-theme")  
        message="这样啊"  
        path="11.默认声响.wav"
        timeout="700"
        ;;  
    "--email-notify")  
        message="有新邮件了哦"  
        path="13.系统通知.wav"
        timeout="1350"
        ;;  
    "--lock")  
        message="我去稍微揍一下辉夜"  
        path="03.程序出错.wav"
        timeout="2200"
        ;;  
    "--resume")  
        message="看来没事了呢"  
        path="06.设备连接.wav"
        timeout="1450"
        ;;  
esac

notify-send "藤原妹红" $message -t $timeout
mpv $sound_dir/$path > /dev/null 2>&1
