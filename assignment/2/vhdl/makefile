
all: analyze synthesize_stage_2_processor simulate_stage_2

analyze: analyze_src analyze_tb

analyze_src:
	@echo "Analyzing src files..."
	@ghdl -a src/types.vhdl
	@ghdl -a src/alu.vhdl src/program_memory.vhdl src/data_memory.vhdl src/reg_file.vhdl
	@ghdl -a src/program_counter.vhdl src/decoder.vhdl src/flag_circuit.vhdl src/cond_checker.vhdl
	@ghdl -a src/processor.vhdl
	@echo "Analysis over"
	@echo ""

analyze_tb:
	@echo "Analyzing testbenches..."
	@ghdl -a tests/alu_tb.vhdl tests/data_memory_tb.vhdl tests/program_memory_tb.vhdl tests/reg_file_tb.vhdl 
	@ghdl -a tests/program_counter_tb.vhdl tests/flag_circuit_tb.vhdl
	@ghdl -a tests/processor_tb.vhdl
	@echo "Analysis over"
	@echo ""

simulate_stage_1:
	@echo "Simulating stage 1 testbenches..."
	@ghdl -r alu_tb --wave=output/alu_tb.ghw
	@ghdl -r reg_file_tb --stop-time=1us --wave=output/reg_file_tb.ghw
	@ghdl -r data_memory_tb --stop-time=2500ns --wave=output/data_memory_tb.ghw
	@ghdl -r program_memory_tb --wave=output/program_memory_tb.ghw
	@echo "Simulation over"
	@echo ""

simulate_stage_2: simulate_stage_2_components simulate_stage_2_processor
	@echo "Simulation over"
	@echo ""

simulate_stage_2_components:
	@echo "Simulating stage 2 testbenches..."
	@ghdl -r program_counter_tb --wave=output/program_counter_tb.ghw --stop-time=1us
	@ghdl -r flag_circuit_tb --wave=output/flag_circuit_tb.ghw --stop-time=1us

simulate_stage_2_processor:
	@ghdl -r processor_tb --wave=output/processor_tb.ghw --stop-time=60ns --ieee-asserts=disable

synthesize_stage_2_processor:
	@echo "Synthesizing stage 2 processor.."
	@ghdl synth processor > output/processor_synth.vhdl
	@echo "Synthesis done"
	@echo ""

clean:
	@echo "Cleaning temporary files..."
	@ghdl --clean
	@ghdl --remove
