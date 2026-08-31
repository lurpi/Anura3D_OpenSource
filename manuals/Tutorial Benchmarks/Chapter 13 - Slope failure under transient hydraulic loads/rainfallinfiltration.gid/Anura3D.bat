@echo off
rem basename = %1
rem modeldirectory = %2
rem problemtypedir = %3
rem A3Dfolder = %4
rem OutputFile = %4\%1.PROC
rem ErrorFile: %2\%1.err
if exist %2\%1.POST.lst del %2\%1.POST.lst
if exist %4\%1.BMR del %4\%1.BMR
if exist %4\%1.BMS del %4\%1.BMS
if exist %4\%1.TST del %4\%1.TST
if exist %4\%1_000.RX del %4\%1_000.RX
copy %2\%1-1.dat %2\%1.CPS_023
if exist %4\%1.CPS_023 del %4\%1.CPS_023
copy %2\%1.CPS_023 %4\%1.CPS_023
copy %2\%1-2.dat %2\%1.GOM_stage2
if exist %4\%1.GOM_stage2 del %4\%1.GOM_stage2
copy %2\%1.GOM_stage2 %4\%1.GOM_stage2
if exist %2\%1.MAPF copy %2\%1.MAPF %4\%1.MAPF
