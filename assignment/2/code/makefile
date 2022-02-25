all: analyze analyze simulate

analyze: analyze_src analyze_tb

analyze_src:
	@echo "Analyzing VHDL component files..."
	@ghdl -a hdl/types.vhdl
	@ghdl -a hdl/alu.vhdl hdl/memory.vhdl hdl/reg_file.vhdl
	@ghdl -a hdl/program_counter.vhdl hdl/decoder.vhdl hdl/flag_circuit.vhdl hdl/cond_checker.vhdl
	@ghdl -a hdl/processor.vhdl
	@echo "Analysis over"
	@echo ""

analyze_tb:
	@echo "Analyzing Processor testbench..."
	@ghdl -a tests/processor_tb.vhdl
	@echo "Analysis over"
	@echo ""

simulate:
	@echo "Processor simulation started"
	@ghdl -r processor_tb --stop-time=120ns --ieee-asserts=disable --wave=simulation/processor.ghw
	@echo "Simulation over"
	@echo ""

clean:
	@echo "Cleaning temporary files..."
	@ghdl --clean
	@ghdl --remove
