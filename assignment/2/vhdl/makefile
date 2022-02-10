
all: analyze simulate clean

analyze: analyze_src analyze_tb

analyze_src:
	@echo "Analyzing src files..."
	@ghdl -a src/types.vhdl
	@ghdl -a src/alu.vhdl src/memory.vhdl src/reg_file.vhdl

analyze_tb:
	@echo "Analyzing testbenches..."
	@ghdl -a tests/alu_tb.vhdl tests/data_memory_tb.vhdl tests/program_memory_tb.vhdl tests/reg_file_tb.vhdl 

simulate:
	@echo "Simulating testbenches..."
	@ghdl -r alu_tb --wave=output/alu_tb.ghw
	@ghdl -r reg_file_tb --stop-time=1us --wave=output/reg_file_tb.ghw
	@ghdl -r data_memory_tb --stop-time=2500ns --wave=output/data_memory_tb.ghw
	@ghdl -r primary_memory_tb --wave=output/primary_memory_tb.ghw

clean:
	@echo "Cleaning temporary files..."
	@ghdl --clean
	@ghdl --remove
