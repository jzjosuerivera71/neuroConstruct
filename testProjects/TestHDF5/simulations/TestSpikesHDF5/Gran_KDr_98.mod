COMMENT

   **************************************************
   File generated by: neuroConstruct v1.5.1 
   **************************************************


ENDCOMMENT


?  This is a NEURON mod file generated from a ChannelML file

?  Unit system of original ChannelML file: SI Units

COMMENT
    A channel from Maex, R and De Schutter, E. Synchronization of Golgi and Granule Cell Firing in a 
    Detailed Network Model of the Cerebellar Granule Cell Layer
ENDCOMMENT

TITLE Channel: Gran_KDr_98

COMMENT
    Delayed rectifyer K channel
ENDCOMMENT


UNITS {
    (mA) = (milliamp)
    (mV) = (millivolt)
    (S) = (siemens)
    (um) = (micrometer)
    (molar) = (1/liter)
    (mM) = (millimolar)
    (l) = (liter)
}


    
NEURON {
      

    SUFFIX Gran_KDr_98
    USEION k READ ek WRITE ik VALENCE 1  ? reversal potential of ion is read, outgoing current is written
           
        
    RANGE gmax, gion
    
    RANGE minf, mtau
    
    RANGE hinf, htau
    
}

PARAMETER { 
      

    gmax = 0.000889691 (S/cm2)  ? default value, should be overwritten when conductance placed on cell
    
}



ASSIGNED {
      

    v (mV)
    
    celsius (degC)
          

    ? Reversal potential of k
    ek (mV)
    ? The outward flow of ion: k calculated by rate equations...
    ik (mA/cm2)
    
    
    gion (S/cm2)
    minf
    mtau (ms)
    hinf
    htau (ms)
    
}

BREAKPOINT { 
                        
    SOLVE states METHOD cnexp
         

    gion = gmax*((m)^4)*((h)^1)      

    ik = gion*(v - ek)
            

}



INITIAL {
    
    ek = -90
        
    rates(v)
    m = minf
        h = hinf
        
    
}
    
STATE {
    m
    h
    
}

DERIVATIVE states {
    rates(v)
    m' = (minf - m)/mtau
    h' = (hinf - h)/htau
    
}

PROCEDURE rates(v(mV)) {  
    
    ? Note: not all of these may be used, depending on the form of rate equations
    LOCAL  alpha, beta, tau, inf, gamma, zeta, temp_adj_m, A_alpha_m, B_alpha_m, Vhalf_alpha_m, A_beta_m, B_beta_m, Vhalf_beta_m, temp_adj_h, A_alpha_h, B_alpha_h, Vhalf_alpha_h, A_beta_h, B_beta_h, Vhalf_beta_h
        
    TABLE minf, mtau,hinf, htau
 DEPEND celsius
 FROM -100 TO 100 WITH 400
    
    
    UNITSOFF
    
    ? There is a Q10 factor which will alter the tau of the gates 
                 

    temp_adj_m = 3^((celsius - 17.350264793)/10)     

    temp_adj_h = 3^((celsius - 17.350264793)/10)
    
    ? There is a voltage offset of 0.010. This will shift the dependency of the rate equations 
    v = v - (10)
    
            
                
           

        
    ?      ***  Adding rate equations for gate: m  ***
         
    ? Found a generic form of the rate equation for alpha, using expression: 170 * ((exp (73 *(v - (-0.038)))))
    
    ? Note: Equation (and all ChannelML file values) in SI Units so need to convert v first...
    
    v = v * 0.001   ? temporarily set v to units of equation...
            
    alpha = 170 * ((exp (73 *(v - (-0.038)))))
        
    ? Set correct units of alpha for NEURON
    alpha = alpha * 0.001 
    
    v = v * 1000   ? reset v
        
     
    ? Found a generic form of the rate equation for beta, using expression: 170 * ((exp ((-18) *(v - (-0.038)))))
    
    ? Note: Equation (and all ChannelML file values) in SI Units so need to convert v first...
    
    v = v * 0.001   ? temporarily set v to units of equation...
            
    beta = 170 * ((exp ((-18) *(v - (-0.038)))))
        
    ? Set correct units of beta for NEURON
    beta = beta * 0.001 
    
    v = v * 1000   ? reset v
        
    mtau = 1/(temp_adj_m*(alpha + beta))
    minf = alpha/(alpha + beta)
          
       
    
    ?     *** Finished rate equations for gate: m ***
    

    
            
                
           

        
    ?      ***  Adding rate equations for gate: h  ***
         
    ? Found a generic form of the rate equation for alpha, using expression: v > -0.046 ? 0.76 : 0.7 + 0.065*(exp (-80*(v - (-0.046))))
    
    ? Note: Equation (and all ChannelML file values) in SI Units so need to convert v first...
    
    v = v * 0.001   ? temporarily set v to units of equation...
            
    
    
    if (v > -0.046 ) {
        alpha =  0.76 
    } else {
        alpha =  0.7 + 0.065*(exp (-80*(v - (-0.046))))
    }
    ? Set correct units of alpha for NEURON
    alpha = alpha * 0.001 
    
    v = v * 1000   ? reset v
        
     
    ? Found a generic form of the rate equation for beta, using expression: 1.1/(1 + (exp (-80.7 * (v - (-0.044)))))
    
    ? Note: Equation (and all ChannelML file values) in SI Units so need to convert v first...
    
    v = v * 0.001   ? temporarily set v to units of equation...
            
    beta = 1.1/(1 + (exp (-80.7 * (v - (-0.044)))))
        
    ? Set correct units of beta for NEURON
    beta = beta * 0.001 
    
    v = v * 1000   ? reset v
        
    htau = 1/(temp_adj_h*(alpha + beta))
    hinf = alpha/(alpha + beta)
          
       
    
    ?     *** Finished rate equations for gate: h ***
    

         

}


UNITSON


