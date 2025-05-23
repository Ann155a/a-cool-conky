conky.config = {
    alignment = 'top_right',
    use_xft = true,
    xftalpha = 0.8,
    font = 'Noto:normal:size=8',
    text_buffer_size = 2048,
    update_interval = 1.0,
    total_run_times = 0,
    background = true,
    double_buffer = true,
    no_buffers = true,
    imlib_cache_size = 0,
    cpu_avg_samples = 2,
    own_window = true,
    own_window_class = 'Conky',
    own_window_argb_visual = true,
    own_window_argb_value = 50,
    own_window_transparent = true,
    own_window_type = 'normal',
    own_window_hints = 'undecorated,below,skip_taskbar,sticky,skip_pager',
    own_window_colour = '000000',
    draw_shades = no,
    default_shade_color = '000000',
    draw_outline = no,
    default_outline_color = '000000',
    draw_borders = no,
    gap_x = 10,
    gap_y = 10,
    minimum_height = 5,
    minimum_width = 205,
    draw_graph_borders = true,
    show_graph_scale = no,
    show_graph_range = no,
    short_units = yes,
    override_utf8_locale = yes,
    uppercase = no,
    default_color = 'ffffff',
    color1 = 'c6396b',
    color2 = 'fc8c3b',
    color3 = 'f9e30f',
    color4 = '4291e2',
    color5 = '161925',
    color6 = '3bf4bb',
    use_spacer = none,
    hddtemp_host = "127.0.0.1",
    hddtemp_port = "7634",
}

conky.text = [[
#Title
${goto 10}${font Noto:bold:size=12}${alignc}Anisa's Desktop
${font Noto:bold:size=10}${alignc}${color2}${time %r}
# day/time
${font Noto:normal:size=9}${goto 10}Date:${color2}${alignr 10}${time %d %B %Y}${color}
${goto 10}Host:${color2}${alignr 10}${exec hostname}
${goto 10}${color}Kernel:${alignr 10}${color2}${kernel}${color}
${goto 10}Uptime:${color2}${alignr 10}$uptime
#
#Processor section
${color4}${hr}${color}
${alignc}${color6}${font Noto:normal:size=9}${exec cat /proc/cpuinfo|grep 'model name'|sed -e 's/model name.*: //'| uniq | cut -c 18-30}${color} @ ${color6}${freq_g 1}GHz
${font}${alignc}${color}Active Governor: ${color6}${execi 1 cut -b 1-20 /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor}${color}
${goto 10}${color}Current Vcore: ${color6}${execi 1 sensors | grep 'Vcore' | cut -c 27-35} ${alignr 10}${color}Max Vcore: ${color1}${execi 1 sensors | grep 'Vcore' | cut -c 61-67
}
#
#Cores
# Cores 1–4
${font Noto:normal:size=8}${goto 10}${color}C1: ${color2}${cpu cpu1}% ${goto 80}${color1}${exec sensors | grep 'Core 0' | awk '{print $3}'}${color}${goto 140}C2: ${color2}${cpu cpu2}% ${alignr 10}${color1}${exec sensors | grep 'Core 1' | awk '{print $3}'}
${goto 10}${color5}${cpugraph cpu1 20,110 fc8c3b c6396b -t} ${alignr 10}${color5}${cpugraph cpu2 20,110 fc8c3b c6396b -t}
${color}${goto 10}C3: ${color2}${cpu cpu3}% ${goto 80}${color1}${exec sensors | grep 'Core 2' | awk '{print $3}'}${color}${goto 140}C4: ${color2}${cpu cpu4}% ${alignr 10}${color1}${exec sensors | grep 'Core 3' | awk '{print $3}'}
${goto 10}${color5}${cpugraph cpu3 20,110 fc8c3b c6396b -t} ${alignr 10}${color5}${cpugraph cpu4 20,110 fc8c3b c6396b -t}
# Average Temperature of All Cores
${font Noto:normal:size=8}${goto 10}${color}Avg Temp: ${color2}${execi 10 sensors | grep 'temp' | awk '{print $2}' | sed 's/+//;s/°C//' | awk '{sum+=$1} END {if (NR > 0) print sum / NR; else print "N/A"}'}${color}
#
#
# GPU Section
${color4}${hr}
###-------------GPU2-------------###
${color}${alignc}${font Noto:normal:size=9}GPU2: 
${color6}NVIDIA GeForce GTX 1050 Mobile${font}${color}
${goto 10}Pwr: ${color6}${execi 1 nvidia-smi --query-gpu=power.draw --format=csv,noheader,nounits} W ${alignr 10}${color}Max Pwr: ${color1}${execi 1 nvidia-smi --query-gpu=power.limit --format=csv,noheader,nounits} W
${color}${goto 10}GPU Load: ${color2}${execi 1 nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits} %${alignr 10}${color}GPU VRAM: ${color2}${execi 1 nvidia-smi --query-gpu=memory.used --format=csv,noheader,nounits} MB
${color5}${goto 10}${execigraph 1 "nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits" 20,110 fc8c3b c6396b -t} ${alignr 10}${execigraph 1 "nvidia-smi --query-gpu=memory.used --format=csv,noheader,nounits" 20,110 fc8c3b c6396b -t}
${goto 10}${color}GPU Temp: ${color1}${execi 1 nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits} °C ${alignr 10}${color}Fan Spd: ${color2}${execi 1 nvidia-smi --query-gpu=fan.speed --format=csv,noheader,nounits} RPM
#
#
# top memory
${color4}${hr}${color}
${goto 10}${color}Current RAM Usage: ${alignr 10}${color6}${memperc}%
${goto 15}${color5}${memgraph 20,220 fc8c3b c6396b -t}
${goto 10}${color1}${top_mem name 1}${alignr 10}${color}${top mem 1}%
${color1}${goto 10}${top_mem name 2}${alignr 10}${color}${top mem 2}%
${color1}${goto 10}${top_mem name 3}${alignr 10}${color}${top mem 3}%
#
#Network
${color4}${hr}${color}
${goto 10}Internal IP: ${color6}${alignr 10}${addr wlan0}
${goto 10}SSID: ${wireless_essid wlan0}
${goto 10}Signal: ${goto 70}${color1}${execbar awk '/signal/ {print 100 + $2}' <(iw dev wlan0 link)}${alignr 10}${exec awk '/signal/ {print 100 + $2}' <(iw dev wlan0 link)}%
${goto 10}External: ${alignr 10}${execi 3600 curl -s --max-time 2 ipinfo.io/ip || echo "No Conn"}
${goto 10}Up Spd:   ${color2}${upspeed wlan0}${goto 140}Down Spd: ${alignr 10}${color2}${downspeed wlan0}
${goto 10}Total Up: ${color2}${totalup wlan0}${goto 140}Total Dn: ${alignr 10}${color2}${totaldown wlan0}
${goto 15}${color5}${upspeedgraph wlan0 20,110 fc8c3b c6396b -t}   ${color5}${downspeedgraph wlan0 20,110 fc8c3b c6396b -t}
#
#Storage
${color4}${hr}${color}
#${goto 10}${color}Disk I/O Scheduler: ${color2}${alignr 10}${ioscheduler /dev/nvme}
#${goto 10}${color}NVME Disk I/O:    ${goto 105}${color}Read:${color2}${diskio_read nvme0n1}${goto 180}${color}Write:${color2}${diskio_write nvme0n1}
${goto 10}${color}Sys:      ${alignr 10}${color6}${fs_used /}${color}  /  ${color2}${alignr 10}${fs_size /}
${goto 15}${color}NVM Temp: ${goto 80}${color1}${exec nvme smart-log /dev/nvme0 | grep 'temperature' | cut -c 39-42}${alignr 10}${color}Available:  ${color6}${fs_free_perc /}%
#
${goto 10}${color}Home:      ${alignr 10}${color6}${fs_used /home}${color}  /  ${color2}${alignr 10}${fs_size /home}
${goto 15}${color}SSD Temp: ${goto 80}${color1}${exec hddtemp /dev/sda | cut -c 33-37}${alignr 10}${color}Available:  ${color6}${fs_free_perc /home}%
#
]]
