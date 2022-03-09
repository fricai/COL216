cur_path=$(readlink -f $0 | sed 's|\(.*\)/.*|\1|')
arm-linux-gnueabi-as $1 -o $cur_path/tmp.o
arm-linux-gnueabi-objdump --disassemble $cur_path/tmp.o | tail -n +7 | cut -f 2 | awk '$0 !~ /\</' | awk 'NF > 0'
rm $cur_path/tmp.o
