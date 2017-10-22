%plots
%Spool Position
subplot(321)
plot(data4.Time, data4.SpoolPOS,'r', tout, x_spool, 'b')
hold on
legend('measured spool pos','simulated spool pos')
title 'Valve Control'
xlabel('Time [s]')
ylabel('Spool Position [m]')

%Pressure
subplot(322)
plot(data4.Time, (data4.pA)/1e6, 'r', tout, (Pressure_A)/1e6, 'b', data4.Time, (data4.pB)/1e6, 'y', tout, (Pressure_B)/1e6, 'g', data4.Time, (data4.pS)/1e6, 'c', tout, (p_S)/1e6, 'b')
hold on
legend('measured pA','simulated pA','measured pB','simulated pB','measured pS','simulated pS')
title 'Pressure'
xlabel('Time [s]')
ylabel('Presure [MPa]')

%Position
subplot(323)
plot(data4.Time, data4.CylPOS, 'r', tout, Position_x, 'b')
hold on
legend('measured x','simulated x')
title 'Position'
xlabel('Time [s]')
ylabel('Position [m]')

%Boom Angle
subplot(324)
plot(data4.Time, data4.BoomTHETA, 'r', tout, Meas_JointAngle, 'b')
hold on
legend('measured Theta','simulated Theta')
title 'Boom Angle'
xlabel('Time [s]')
ylabel('Theta [deg]')

%Velocity
ts = data4.Time(2)-data4.Time(1);
Data_Velocity = diff(data4.CylPOS)/ts;
t_new = data4.Time(1:end-1);
subplot(325) 
plot(t_new, Data_Velocity, 'r', tout, Velocity, 'b')
hold on
legend('measured v','simulated v')
title 'Velocity'
xlabel('Time [s]')
ylabel('Velocity [m/s]')

%Force
F_cyl = data4.pA*Cyl.A_A - data4.pB*Cyl.A_B;
subplot(326)
plot(data4.Time,F_cyl, 'r', tout, Force, 'b')
hold on
legend('measured F','simulated F')
title 'Force'
xlabel('Time')
ylabel('Force')