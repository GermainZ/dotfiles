function 720p
    ffmpeg -i $argv[1] -vf scale=-1:720 -c:v libx265 -crf 24 -c:a aac -b:a 128k -scodec copy $argv[2]
end
