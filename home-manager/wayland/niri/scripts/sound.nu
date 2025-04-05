#!/usr/bin/env nu

# Examples: nu sound.sh --kind <arg>
# 
# nu sound.sh --kind low-battery
# nu sound.sh --kind lock

def main [--kind: string] {
  let assets_dir = ($env.FILE_PWD | path join "../assets")
  
  # list : (text, path, timeout)
  let list = match $kind {
    "low-battery"              => ["电池电量低下了\n(电量30%)", "09.电池不足警告.wav", "1800"]
    "very-low-battery"         => ["所以我就说了吧......\n(电量15%)", "08.电池严重短缺警告.wav", "2200"]
    "shutdown"                 => ["完事了呢，下次再见吧"  , "02.关机.wav", "2800"]
    "startup"                  => ["成功启动了呢，辛苦你了", "01.开机.wav", "2700"]
    "sleep"                    => ["现在不在，留守中......\n之后再过来吧"  , "15.休眠.wav", "3850"]
    "default" | "change-theme" => ["这样啊"  , "11.默认声响.wav", "700"]
    "email-notify"             => ["有新邮件了哦"  , "13.系统通知.wav", "1350"]
    "lock"                     => ["我去稍微揍一下辉夜"  , "03.程序出错.wav", "2200"]
    "resume"                   => ["看来没事了呢"  , "06.设备连接.wav", "1450"]
    _                          => { error make -u { msg: "Invalid arguments" } }
  }

  let text = ($list | get 0)
  let path = ($list | get 1)
  let timeout = ($list | get 2)

  notify-send -i ($assets_dir | path join "mokou.png") "藤原妹红:" $text -t $timeout
  mpv --no-loop ($assets_dir | path join "sounds/妹红" $path) o> /dev/null
}
