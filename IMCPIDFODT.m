function [GcPIDn, GcPIDd] = IMCPIDFODT(tau,K,theta,tauc,alpha)

tauI = tau + 0.5*theta;
tauD = tau*theta/(2*tauI);
Kc = (2*tauI)/(K*(2*tauc + theta));

GcPIDn = Kc*conv([tauI 1],[tauD 1]);
GcPIDd = conv([alpha*tauD 1],[tauI 0]);