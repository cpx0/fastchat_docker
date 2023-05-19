#!/bin/bash -e

CMDNAME=`basename $0`

function main() {

    if [ $# -eq 0 ]; then
        echo -e \
            "python -m fastchat.serve.cli --model-path ./vicuna-7b --load-8bit"
        python -m fastchat.serve.cli \
            --model-path ./vicuna-7b \
            --load-8bit
    else
        while getopts m:g:8o OPT
        do
            case $OPT in
                "m" ) FLG_M="TRUE" ; MODEL="$OPTARG" ;;
                "g" ) FLG_G="TRUE" ; GPUS=$OPTARG ;;
                "8" ) FLG_8="TRUE" ;;
                "o" ) FLG_O="TRUE" ;;
                * ) echo "Usage: $CMDNAME [-m PATH] [-g NUM] [-8] [-o]" 1>&2
                    exit 1 ;;
            esac
        done

        if [ "$FLG_M" = "TRUE" ]; then
            if [ $GPUS >= 0 ]; then
                if [ "$FLG_8" = "TRUE" ]; then
                    if [ "$FLG_O" = "TRUE" ]; then
                        echo -e \
                            "python -m fastchat.serve.cli --model-path $MODEL --num-gpus $GPUS --load-8bit --cpu-offloading"
                        python -m fastchat.serve.cli \
                            --model-path $MODEL \
                            --num-gpus $GPUS \
                            --load-8bit \
                            --cpu-offloading
                    else
                        echo -e \
                            "python -m fastchat.serve.cli --model-path $MODEL --num-gpus $GPUS --load-8bit"
                        python -m fastchat.serve.cli \
                            --model-path $MODEL \
                            --num-gpus $GPUS \
                            --load-8bit
                    fi
                elif [ "$FLG_O" = "TRUE" ]; then
                    echo -e \
                        "python -m fastchat.serve.cli --model-path $MODEL --num-gpus $GPUS --cpu-offloading"
                    python -m fastchat.serve.cli \
                        --model-path $MODEL \
                        --num-gpus $GPUS \
                        --cpu-offloading
                else
                    echo -e \
                        "python -m fastchat.serve.cli --model-path $MODEL --num-gpus $GPUS"
                    python -m fastchat.serve.cli \
                        --model-path $MODEL \
                        --num-gpus $GPUS
                fi
            elif [ $GPUS = 0 ]; then
                echo -e \
                    "python -m fastchat.serve.cli --model-path $MODEL --device cpu"
                python -m fastchat.serve.cli \
                    --model-path $MODEL \
                    --device cpu
            else
                echo "-g(GPU_NUMS) option must be nonnegative integer" 1>&2
                exit 1
            fi
        else
            echo -e \
            "python -m fastchat.serve.cli --model-path ./vicuna-7b"
            python -m fastchat.serve.cli \
                --model-path ./vicuna-7b
        fi
    fi

    exit 0;
}

main "$@"
