#!/bin/bash -e

CMDNAME=`basename $0`

function main() {

    while getopts m:l OPT
    do
        case $OPT in
            "m" ) FLG_M="TRUE" ; MODEL="$OPTARG" ;;
            "l" ) FLG_L="TRUE" ; GPUS=$OPTARG ;;
            * ) echo "Usage: $CMDNAME [-m 7b/13b] [-l]" 1>&2
                exit 1 ;;
        esac
    done

    if [ "$FLG_M" = "TRUE" ]; then
        if [ "$FLG_L" = "TRUE" ]; then
            if [ "$MODEL" = "7b"]; then
                python -m fastchat.model.apply_delta \
                    --base-model-path ./llama-7b-hf \
                    --target-model-path ./vicuna-7b \
                    --delta-path ./vicuna-7b-delta-v1.1 \
                    --low-cpu-mem
            elif [ "$MODEL" = "13b"]; then
                python -m fastchat.model.apply_delta \
                    --base-model-path ./llama-13b-hf \
                    --target-model-path ./vicuna-13b \
                    --delta-path ./vicuna-13b-delta-v1.1 \
                    --low-cpu-mem
            else
                echo "Usage: $CMDNAME [-m 7b/13b] [-l]" 1>&2
                exit 1 ;;
            fi
        else
            if [ "$MODEL" = "7b"]; then
                python -m fastchat.model.apply_delta \
                    --base-model-path ./llama-7b-hf \
                    --target-model-path ./vicuna-7b \
                    --delta-path ./vicuna-7b-delta-v1.1
            elif [ "$MODEL" = "13b"]; then
                python -m fastchat.model.apply_delta \
                    --base-model-path ./llama-13b-hf \
                    --target-model-path ./vicuna-13b \
                    --delta-path ./vicuna-13b-delta-v1.1
            else
                echo "Usage: $CMDNAME [-m 7b/13b] [-l]" 1>&2
                exit 1 ;;
            fi
        fi
    else
        echo "Usage: $CMDNAME [-m 7b/13b] [-l]" 1>&2
        exit 1 ;;
    fi

    exit 0;
}

main "$@"
