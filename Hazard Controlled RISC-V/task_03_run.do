vlog *.v
vsim -novopt work.tb_RISC_V_3
view wave

add wave sim:/tb_RISC_V_3/risc_v/Data_Memory/memory
add wave sim:/tb_RISC_V_3/risc_v/reg_file/Registers
add wave sim:/tb_RISC_V_3/*
add wave sim:/tb_RISC_V_3/risc_v/*
run 2000ns