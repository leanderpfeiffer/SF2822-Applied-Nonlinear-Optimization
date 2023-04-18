$Title Optimization of final satellite Orbit
Parameters
    N  final step /100/
    mu      /1.327 * 10^20/
    r_0     /1.496*10^11/
    m_0     /4.53*10^3/
    m_dot   /6.76 * 10^-5/
    t_f     /1.668*10^7/
    T       /3.77/;
    
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
    end_condition_x1