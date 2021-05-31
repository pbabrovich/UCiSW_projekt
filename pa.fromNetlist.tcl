
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name Pong_VGA -dir "C:/Users/enkor/Downloads/UCiSW_projekt-led/planAhead_run_2" -part xc6slx9ftg256-3
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "C:/Users/enkor/Downloads/UCiSW_projekt-led/vga_driver.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/Users/enkor/Downloads/UCiSW_projekt-led} }
set_property target_constrs_file "vga_config.ucf" [current_fileset -constrset]
add_files [list {vga_config.ucf}] -fileset [get_property constrset [current_run]]
link_design
