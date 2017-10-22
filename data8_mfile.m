%4/3 valve

%Valve Dynamics

%2nd order transfer function
Valve.secondorder_delay = 0.03;
Valve_omega = 38;
Valve_eta = 0.99;

%RELATIVE OPENINGS
%Look-up Tabel PA
%figure(1),clf
%plot(data1.SpoolPOS, data1.QA/max(data1.QA))
%xlabel('spool position PA'); ylabel('flow QA')
Valve.lookupopenPA = [5.86e-4 5.86e-4 5.86e-4 0.0329 0.1003 0.1600 0.6635 1];
Valve.lookupspoolPA = [-1 -0.5 0 0.2 0.4 0.5 0.8 1];

%Look-up Tabel PB
%figure(3),clf
%plot(data2.SpoolPOS, data2.QB/max(data2.QB))
%xlabel('spool position PB'); ylabel('flow QB')
Valve.lookupopenPB = [1 0.4951 0.1599 0.0997 0.0324 5.86e-4 5.86e-4 5.86e-4];
Valve.lookupspoolPB = [-1 -0.7 -0.5 -0.4 -0.2 0 0.5 1];

%Look-up Tabel BT
%figure(2),clf
%plot(data1.SpoolPOS, data1.QB/min(data1.QB))
%xlabel('spool position BT'); ylabel('flow QB')
Valve.lookupopenBT = [0.00115 0.00115 0.00115 0.0347 0.1102 0.2088 0.6821 1];
Valve.lookupspoolBT = [-1 -0.5 0 0.2 0.4 0.5 0.8 1];

%Look-up Tabel AT
%figure(4),clf
%plot(data2.SpoolPOS, data2.QA/min(data2.QA))
%xlabel('spool position AT'); ylabel('flow QA')
Valve.lookupopenAT = [1 0.5189 0.1990 0.1118 0.0343 0.00115 0.00115 0.00115];
Valve.lookupspoolAT = [-1 -0.7 -0.5 -0.4 -0.2 0 0.5 1];


%Nominal flow rates
%Nominal Flow-rate PA
%figure(5),clf
%plot((data4.pS-data4.pA), data4.QA)
%xlabel('pressure difference PA'); ylabel('flow QA')

%Nominal Flow-rate BT
%figure(6),clf
%plot((data4.pB-data4.pT), data4.QB)
%xlabel('pressure difference BT'); ylabel('flow QB')

%Nominal Flow-rate PB
%figure(7),clf
%plot((data5.pS-data5.pB), data5.QB)
%xlabel('pressure difference PB'); ylabel('flow QB')

%Nominal Flow-rate AT
%figure(8),clf
%plot((data5.pA-data5.pT), data5.QA)
%xlabel('pressure difference AT'); ylabel('flow QA')

%Orifice/Flowpath Parameters
Valve.QN.PA = 0.001862;  % Nominal flow rate [m3/s]
Valve.QN.BT = 0.0007461;
Valve.QN.PB = 0.0007441;
Valve.QN.AT = 0.001864;
Valve.dpN = 0.5e6; % Nominal pressure difference [Pa]
Valve.ptr = 0.1e6; % Transition pressure [Pa]



load('System_data.mat')
%U valve
U_signal = [data8.Time data8.Uvalve];

%Supply Pressure
%plot(data8.Time,data8.pS)
Supply_pr_Ps = 2.1e7;

%Hose Block
Hose.B = 400e6;                          %Bulk Modulus (N/m2)
Hose.d = 25e-3;                          %Diameter of hose (m)
Hose.length_A = 5;                    %Hose lenghth connected to port A (m)
Hose.length_B = 6;                   %Hose lenghth connected to port B(m)
Hose.V_A = ((pi*Hose.length_A)/4)*Hose.d^2;  %Volume at port A(m3)
Hose.V_B = ((pi*Hose.length_B)/4)*Hose.d^2;  %Volume at port B(m3)
Hose.pa_init = 1961873.46053293;                       %Initial pressure(pa)
Hose.pb_init = 6617272.14908948;
Hose.dpN = 0.5e6;
Hose.mu = 0.7;
Hose.Area = (pi/4)*(Hose.d)^2;
Hose.Eta = 870;
Hose.QN = Hose.mu*Hose.Area*sqrt(2*Hose.dpN/Hose.Eta);
Hose.ptr = 0.1e6;                % Transition pressure [Pa]


% Actuator

%Cylinder
Cyl.D = 145e-3;                 % Piston diameter A-side [m]
Cyl.d = 95e-3;                  % Piston diameter B-side [m]
Cyl.A_A = pi*(Cyl.D)^2/4;       % Piston area A-side [m2]
Cyl.V0A = 0.2e-3;                % Dead volume at A-side [m3]
Cyl.A_B = pi*((Cyl.D)^2-(Cyl.d)^2)/4;               % Piston area B-side area [m2]
Cyl.V0B = 0.2e-3;               % Dead volume at B-side [m3]
Cyl.B = 1323e6;                 % Effective bulk modulus [Pa]
Cyl.xmax = 1.150;               %Stroke Length (m)
Cyl.pa_init = 1961873.46053293;   % [Pa]
Cyl.pb_init = 6617272.14908948;

%Friction Model
Load.m = 1650; % in kg
Cyl.F_S =  5000;       % Static friction force [N]
Cyl.F_C =  4850;       % Coulombic friction force [N]
Cyl.b = 10000;        % Viscous friction coefficient [Ns/m]
Cyl.v_s = 0.8; % Parameter related to minimum friction vel. [m/s]
zmax = 0.1e-3;       %
Cyl.sigma_0 = Cyl.F_S/zmax;      % (such that maximum seal deformation is 0.1 mm)
Cyl.sigma_1 = 0.5*sqrt(Cyl.sigma_0*Load.m); % Damping term of seal
vv = linspace(0,0.1,500);
%plot(vv,Cyl.F_C+(Cyl.F_S-Cyl.F_C)*exp(-(vv/Cyl.v_s).^2)+Cyl.b*vv)
%plot(tout,v)

% Mechanism
Cyl.x_min=2;

Boom.Mass = 1000;
Boom.Inert = [0 0 0; 0 0 0; 0 0 0];
Boom.CylJoint = [2.2841 1.8972 0];
Boom.ArmJoint = [4.6501 1.0896 0];

Arm.Mass = 850;
Radius.arm = 0.21;
Arm.Length = 3.424;
Arm.CG = [0.8 0.21 0];
Arm.Orient = [0 0 data8.BoomTHETA(1)];
Arm.CylJoint = [-0.644 0.345 0];
Arm.BucketJoint = [2.780 0.106 0];

Bucket.Mass = 800;
Bucket.CG = [0.5 0 0];
Radius.bucket = 0.5;
Arm.Inertia = [0, 0, 0; 0, (Arm.Mass*3.424^2)/12, 0; 0, 0, (Arm.Mass*3.424^2)/12];
Bucket.Interia = [(2/5)*Bucket.Mass*Radius.bucket^2, 0, 0; 0, (2/5)*Bucket.Mass*Radius.bucket^2, 0; 0, 0, (2/5)*Bucket.Mass*Radius.bucket^2];

sim 'projectmodel'

run 'data8_plots'
