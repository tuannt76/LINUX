# Chapter 29: Programmable completion Hoàn thành lập trình

## 29.1: Simple completion using function - Hoàn thành đơn giản bằng cách sử dụng chức năng

```
_mycompletion() {
    local command_name="$1" #không được sử dụng trong ví dụ này
    local current_word="$2"
    local previous_word="$3" #không được sử dụng trong ví dụ này
    # COMPREPLY là một mảng phải được lấp đầy bởi các phần hoàn chỉnh có thể có
    # compgen được sử dụng để lọc các kết quả phù hợp
    COMPREPLY=( $(compgen -W 'hello world' -- "$current_word") )
}
complete -F _mycompletion mycommand
```

Ví dụ sử dụng:

```
$ mycommand [TAB][TAB]
hello world
$ mycommand h[TAB][TAB]
$ mycommand hello
```

## 29.2: Simple completion for options and filenames - Hoàn thành đơn giản cho các tùy chọn và tên tệp

```
# Hàm shell sau sẽ được sử dụng để tạo các phần hoàn chỉnh cho
# lệnh "nuance_tune".
_nuance_tune_opts ()
{
    local curr_arg prev_arg
    curr_arg=${COMP_WORDS[COMP_CWORD]}
    prev_arg=${COMP_WORDS[COMP_CWORD-1]}

    # Tùy chọn "cấu hình" lấy một đối số tệp, vì vậy hãy lấy danh sách các tệp trong
    # dir hiện tại. Ở đây có lẽ không cần sử dụng một câu lệnh tình huống, nhưng hãy để lại
    # phòng để tùy chỉnh các thông số cho các cờ khác.
    case "$prev_arg" in
        -config)
            COMPREPLY=( $( /bin/ls -1 ) )
            return 0
            ;;
        esac

        # Sử dụng compgen để cung cấp các phần hoàn chỉnh cho tất cả các tùy chọn đã biết.
        COMPREPLY=( $(compgen -W '-analyze -experiment -generate_groups -compute_thresh -config -output
-help -usage -force -lang -grammar_overrides -begin_date -end_date -group -dataset -multiparses -
dump_records -no_index -confidencelevel -nrecs -dry_run -rec_scripts_only -save_temp -full_trc -
single_session -verbose -ep -unsupervised -write_manifest -remap -noreparse -upload -reference -
target -use_only_matching -histogram -stepsize' -- $curr_arg ) );
}

#Tham số -o yêu cầu Bash xử lý các lần hoàn tất dưới dạng tên tệp, nếu có.

complete -o filenames -F _nuance_tune_opts nuance_tune
```
