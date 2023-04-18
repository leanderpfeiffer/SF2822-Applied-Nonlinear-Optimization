$Title Optimization of final satellite Orbit
Parameters
    N
    mu
    r_0
    m_0
    m_dot
    t_f
    T
    c_1
    c_2
    c_3;
    
N = 100;
mu  = 1.327 * 10^20;
r_0 = 1.496*10^11;
m_0 = 4.53*10^3;
m_dot = 6.76 * 10^-5;
t_f = 1.668*10^7;
T   = 3.77;
c_1 = T*r_0*r_0 / (mu*m_0);
c_2 = m_dot * mu^0.5 / (T * r_0^0.5);
c_3 = t_f * mu^0.5 / r_0^(3/2)
 
    
Sets
    n index   / 0*N /;
    
Variables
    x1(n) dimensionless radius
    x2(n) dimensionless radial velocity
    x3(n) dimensionless tangental velocity
    u(n)  angle of thrust;
    
Equations
    start_condition_x1
    start_condition_x2
    start_condition_x3
    end_condition_x2
    end_condition_x3

    transition_x1
    transition_x2
    transition_x3;
    
start_condition_x1 .. x1(0) =e= 1;
start_condition_x2 .. x2(0) =e= 0;
start_condition_x3 .. x3(0) =e= 1;

end_condition_x2 .. x2(N) =e= 0;
end_condition_x3 .. x1(N) * x3(N) * x3(N) =e= 1;

transition_x1 .. x1(n+1) =e= x1(n) + c_3^2/N * x2(n);
transition_x2 .. x2(n+1) =e= x2(n) + x3(n)^2/(N*x_1(n)) - 1/(N*x1(n)^2) + sin(u(n))/(N/c1-c1*c2*n);
transition_x3 .. x3(n+1) =e= x3(n) + c_3^2*x2(n)*x3(n)/(N*x1(n)) + c_3*cos(u(n))/(N/c1-c1*c2*n);

Model orbit_optimization /all/ ;

  Solve orbit_optimization using nlp maximizing x1(N) ;

  Display x1(N)
