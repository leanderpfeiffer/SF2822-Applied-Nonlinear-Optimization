$Title Optimization of final satellite Orbit
Parameters
    N = 100
    mu  = 1.327 * 10^20
    r_0 = 1.496*10^11
    m_0 = 4.53*10^3
    m_dot = 6.76 * 10^-5
    t_f = 1.668*10^7
    T   = 3.77
    c_1 = T*r_0*r_0 / (mu*m_0)
    c_2 = m_dot * sqrt;
 
    
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
    final_x1_value
    transition_x1
    transition_x2
    transition_x3;
    
start_condition_x1 .. x1(0) =e= 1
start_condition_x2 .. x2(0) =e= 0
start_condition_x3 .. x3(0) =e= 1

end_condition_x2 .. x2(N) =e= 0
end_condition_x3 .. x1(N) * x3(N) * x3(N) =e= 1

transition_x1 .. x1(n+1) =e= x1(n) + c