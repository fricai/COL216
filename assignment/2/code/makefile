all: analyze analyze simulate

analyze: analyze_src analyze_tb

analyze_shifter:
	@echo "Analyzing VHDL shifter component files..."
	@ghdl -a hdl/types.vhdl
	@ghdl -a hdl/shifter.vhdl
	@echo "Analysis over"

analyze_src:
	@echo "Analyzing VHDL component files..."
	@ghdl -a hdl/types.vhdl
	@ghdl -a hdl/alu.vhdl hdl/memory.vhdl hdl/reg_file.vhdl
	@ghdl -a hdl/program_counter.vhdl hdl/decoder.vhdl hdl/flag_circuit.vhdl hdl/cond_checker.vhdl
	@ghdl -a hdl/processor.vhdl
	@echo "Analysis over\n"

analyze_tb:
	@echo "Analyzing Processor testbench..."
	@ghdl -a tests/processor_tb.vhdl
	@echo "Analysis over\n"

simulate:
	@echo "Processor simulation started"
	@ghdl -r processor_tb --stop-time=120ns --ieee-asserts=disable --wave=simulation/processor.ghw
	@echo "Simulation over\n"

testarm:
	@echo "Testing against arm files.."
	@echo ""
	@echo "Generating memory file..."
	@echo ""
	@./arm/scripts/create-mem.sh ./arm/assembly/$(INPUT).s > ./hdl/memory.vhdl
	@echo "Generated memory file"
	@echo ""
	@echo "Analyzing VHDL component files..."
	@ghdl -a hdl/types.vhdl
	@ghdl -a hdl/alu.vhdl hdl/memory.vhdl hdl/reg_file.vhdl
	@ghdl -a hdl/program_counter.vhdl hdl/decoder.vhdl hdl/flag_circuit.vhdl hdl/cond_checker.vhdl
	@ghdl -a hdl/processor.vhdl
	@echo "Analysis over"
	@echo ""
	@ghdl -a hdl/processor.vhdl
	@echo "Analysis over"
	@echo ""
	@echo "Analyzing Processor testbench..."
	@ghdl -a tests/processor_tb.vhdl
	@echo "Analysis over"
	@echo ""
	@echo "Processor simulation started"
	@ghdl -r processor_tb --stop-time=1us --ieee-asserts=disable --wave=simulation/arm-tests/$(INPUT).ghw
	@echo "Simulation over\n"
	@echo "Cleaning temporary files..."
	@ghdl --clean
	@ghdl --remove

clean:
	@echo "Cleaning temporary files..."
	@ghdl --clean
	@ghdl --remove
