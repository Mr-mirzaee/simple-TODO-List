#!/bin/bash

# Tasks File
file=tasks.csv

function addTask {
    priority="L"
    while [ -n "$1" ]; do
        case $1 in
            -t | --title)
                shift
                title="$1"
                shift
                ;;
            -p | --priority)
                shift
                if [[ "$1" == "H" ]] || [[ "$1" == "M" ]] || [[ "$1" == "L" ]]; then
                    priority="$1"
                    shift
                else
                    echo "Option -p|--priority Only Accept L|M|H"
                    exit 1
                fi
               ;;
            *)
                echo "Invalid Option!"
                exit 1
            ;;
        esac
    done
    if [ -z "${title}" ]; then
        echo "Option -t|--title Needs a Parameter"
        exit 1
    fi
    echo "0,${priority},\"${title}\"" >> $file
    echo "Task \"$title\" Added to List."
}
function listTask {
    i=1
    while IFS=, read isDone priority title
    do
        flag=1
        echo "$i | $isDone | $priority | $title"
        i=$(( $i + 1 ))
    done < $file
    if [ -z $flag ]; then
        echo "No tasks found!"
    fi
}
function clearTask {
    rm -f $file
    echo "Tasks Cleared!"
}
function findTask {
    i=1
    while IFS=, read isDone priority title
    do
        if [[ $title == *"$1"* ]]; then
            flag=1
            echo "$i | $isDone | $priority | $title"
        fi
        i=$(( $i + 1 ))
    done < $file
    if [ -z $flag ]; then
        echo "No tasks found!"
    fi
}
function doneTask {
    if [ -z "$1" ]; then
        echo "Task ID is required!"
        exit 1
    fi
    echo -n "" > "temp"
    i=1
    while IFS=, read isDone priority title
    do
        if [[ $i == $1 ]]; then
            echo "1,$priority,$title" >> "temp"
            echo "Task $1 Done."
            flag=1
        else
            echo "$isDone,$priority,$title" >> "temp"
        fi
        i=$(( $i + 1 ))
    done < $file
    mv -f temp $file
    if [ -z $flag ]; then
        echo "No task found with ID $1!"
    fi
}
function checkExistFile {
    if [ ! -f $file ]; then
        echo "No tasks found!"
        exit 0
    fi
}
case $1 in
add)
    shift
    addTask "$@"
;;
list)
    checkExistFile
    listTask
;;
clear)
    clearTask
;;
find)
    shift
    checkExistFile
    findTask "$@"
;;
done)
    shift
    checkExistFile
    doneTask "$@"
;;
*)
    echo "Command Not Supported!"
;;
esac