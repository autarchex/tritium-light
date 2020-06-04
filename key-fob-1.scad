//key-fob-1, a simple keychain fob made of clear plastic
//Consists of a body and endcap. Body has cylindrical cavity inside to accept a small tritium glow tube. Designed for fishing lures sourced from the UK.
//Seal the fob by using superglue or epoxy to bond the endcap permanently in place.
//units are mm

$fn = 16;

//"gt" refers to "glow tube"
gt_L = 25;                  //length of tritium glow tube
gt_r = 1;                       //radius of tritium glow tube
slop_r = 0.2;               //additional radius to accomodate variation / aid insertion
slop_L = 0.5;            //additional length to accomodate variation in gt_L

T = 1.5;                        //wall thickness (minimum)
cap_plug_L = T*3;     //how far the cap's plug extends into the glowtube channel
cap_head_L = cap_plug_L / 2;    //length of head portion of cap (external portion)
fillet_r = 1;                   //fillet radius
keychain_hole_r = 1;    //radius of hole that keychain attaches to

body_core_x = 2*(gt_r + T - fillet_r);
body_core_y = body_core_x;

//body length
body_L = cap_plug_L + slop_L + gt_L + T + 2*keychain_hole_r + T;

//Glowtube channel length and radius
channel_L = gt_L + slop_L;
channel_r = gt_r + slop_r;

//construct the main body
difference() {
    //an axially centered filleted rectangular prism
    translate( [-body_core_x / 2, -body_core_y / 2, 0] ){
        minkowski() {
            //a rectangular prism forms the core of the body
            cube( size=[body_core_x, body_core_y, body_L ] );
            //a sphere forms the fillet surface of the body via minkowski summation
            sphere( r=fillet_r );
        }
    }
    
    //cut off the region which will be occupied by the cap
    translate( [-50, -50, -50] ) {
        cube( size= [100,100,cap_head_L + 50 ] );
    }
    
    //bore out the channel
    translate( [0, 0, cap_head_L-0.001] ) {
        cylinder( r= channel_r, h = channel_L );
    }
    
    //bore out the keychain hole
    translate( [0,0,0] ) {
        cylinder( r=keychain_hole_r, h=50 );
    }   
}
