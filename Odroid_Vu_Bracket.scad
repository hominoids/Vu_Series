/*
    CloudShell Vu5 and Vu7 Bracket Copyright 2020,2021 Edward A. Kisiel
    hominoid @ www.forum.odroid.com

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
    Code released under GPLv3: http://www.gnu.org/licenses/gpl.html

    20201109 Version 1.0.0  CloudShell Vu7 Bracket
    20210104 Version 1.1.0  added Vu5 bracket
                            added selectable hook size for cloudshell2 or cloudshell4 attachment
                            made vu_prop parametric
    20210128 Version 1.1.1  shortened Vu5 cloudshell hook brace
                            shortened prop
                            code cleanup
                            
*/

use <./fillets.scad>

model=0;                // 0=platter view, 1=model view, 2=debug view
style = "vu7";          // vu5, vu7
size = 5;               // hook size cloudshell2=5mm, cloudshell4=3mm

$fn=90;

// platter view
if(model == 0) {
    if(style == "vu5") {
    translate([0,0,5]) rotate([0,90,0]) vu_csbracket(style,"right",90,75);
    translate([30,0,-70]) rotate([0,-90,0]) translate([0,0,0]) vu_csbracket(style,"left",90,75);
    translate([40,10,0]) cs_vubracket(size,75);
    translate([40,40,0]) cs_vubracket(size,75);
    translate([40,60,0]) vu_prop(39,75);
    }
    if(style == "vu7") {
    translate([0,0,5]) rotate([0,90,0]) vu_csbracket(style,"right",120,100);
    translate([30,0,-95]) rotate([0,-90,0]) translate([0,0,0]) vu_csbracket(style,"left",120,100);
    translate([40,10,0]) cs_vubracket(size,100);
    translate([40,40,0]) cs_vubracket(size,100);
    translate([40,60,0]) vu_prop(48,100);
    }
}
// model view
if(model == 1) {
    if(style == "vu5") {
        translate([0,-40.5,43.5]) rotate([120,0,180]) vu_csbracket(style,"both",90,75);
        translate([0,10,117]) rotate([90,90,90]) cs_vubracket(size,75);
        translate([-80,10,117]) rotate([90,90,90]) cs_vubracket(size,75);
        translate([-75,16,44]) rotate([150,0,0]) vu_prop(39,75);
    }
    if(style == "vu7") {
        translate([0,-55,17]) rotate([120,0,180]) vu_csbracket(style,"both",120,100);
        translate([0,10,117]) rotate([90,90,90]) cs_vubracket(size,100);
        translate([-105,10,117]) rotate([90,90,90]) cs_vubracket(size,100);
        translate([-100,15,22]) rotate([150,0,0]) vu_prop(48,100);
    }
}
// debug
if(model == 2) {
    translate([0,0,0]) vu_prop(48, 100);
}

// create prop
module vu_prop(length, width) {
    adjust = .01;
    difference() {
        union() {
            translate([0,3.5,0]) cube([5,length,7]);
            translate([0,3.5,3.5]) rotate([0,90,0]) cylinder(d=7, h=5);
            translate([width-5,3.5,0]) cube([5,length,7]);
            translate([width-5,3.5,3.5]) rotate([0,90,0]) cylinder(d=7, h=5);
            // horizontals
            translate([0,length+3.5,0]) rotate([0,0,0]) cube([width,3,3.5]);
            translate([0,10,0]) rotate([0,0,0]) cube([width,3,3.5]);
        }
            translate([0-adjust,5,3.5]) rotate([0,90,0]) cylinder(d=3.6, h=5+(adjust*2));
            translate([width-5-adjust,5,3.5]) rotate([0,90,0]) cylinder(d=3.6, h=5+(adjust*2));
            //horizontal trim
            translate([0-adjust,length+3.5,3.5]) rotate([60,0,0]) cube([width+(adjust*2),4+adjust,7]);

    }
}

// cloudshell hook brace
module cs_vubracket(size, length) {
    adjust = .01;
    difference() {
        union() {
            translate([5,2.5,2.5]) 
              cube_fillet_inside([10,25,5], vertical=[3,3,6,3], top=[0,0,0,0], bottom=[0,0,0,0], $fn=60);
            translate([2.55-adjust,0,0]) cube([length,5,5]);
            // lower mount mount block
            translate([length-2.5,-2.5,2.5]) cube_fillet_inside([10,7.5,5], vertical=[0,0,3,3], top=[0,0,0,0], bottom=[0,0,0,0], $fn=60);
        }
        translate([7.5,(size/2)+5,2.5-adjust]) 
          cube_fillet_inside([7.5+adjust,size,6], vertical=[0,1,1,0], top=[0,0,0,0], bottom=[0,0,0,0], $fn=60);
        // vu mount hole
        translate([5,-5,-adjust]) cylinder(d=3.6, h=5+(adjust*2));
        // prop mount holes
        translate([length-2,0,-adjust]) cylinder(d=3.6,h=5+(adjust*2));
    }
}

// vu attcahed brace
module vu_csbracket(style, side, length, width) {
    adjust = .01;
    holesize=3.6;
        difference() {
        union() {
            if(side == "right"  || side == "both") {
                // right vu support
                translate([0,(length/2)-7,2.5]) 
                  cube_fillet_inside([10,length,5],vertical=[0,0,1,1],top=[0,0,0,0],bottom=[0,0,0,0],$fn=60);
                // right vu hinge block
                translate([0,(length-9)-adjust,5]) 
                  cube_fillet_inside([10,12,10],vertical=[1,0,0,1],top=[3,0,3,0],bottom=[3,0,0,0],$fn=60);
            }
        if(side == "left"  || side == "both") {
                // left vu support
                translate([width,(length/2)-7,2.5]) 
                  cube_fillet_inside([10,length,5],vertical=[0,0,1,1],top=[0,0,0,0],bottom=[0,0,0,0],$fn=60);
                // left vu hinge block
                translate([width,(length-9)-adjust,5]) 
                  cube_fillet_inside([10,12,10],vertical=[0,1,1,0],top=[3,0,3,0],bottom=[3,0,0,0],$fn=60);
            }
        }
        if(side == "right"  || side == "both") {        
            // right hinge trim
            translate([-5-adjust,length-15.2,-adjust]) cube([5,14,10+(adjust*2)]);
            translate([0-(adjust*2),length-8,5])  rotate([90,0,90]) cylinder(d=holesize,h=10);
            // 100mm vesa holes
            translate([0,length-20,-adjust]) cylinder(d=3.6,h=5+(adjust*2));
            if(style == "vu5") {
                translate([0,length-70,-adjust]) cylinder(d=3.6,h=5+(adjust*2));
            // prop notchs
            translate([0,length-65,3]) cube([5+adjust,3.5,3.5]);
            }
            if(style == "vu7") {
                translate([0,0,-adjust]) cylinder(d=3.6,h=5+(adjust*2));
            // prop notchs
            translate([0,length-84,3]) cube([5+adjust,3.5,3.5]);
            }
        }
        if(side == "left"  || side == "both") {
            // left hinge trim
            translate([width+adjust,length-15.2,-adjust]) cube([5,14,10+(adjust*2)]);
            translate([width-5-adjust,length-8,5])  rotate([90,0,90]) cylinder(d=holesize,h=10);
            // 100mm vesa holes            
            translate([width,length-20,-adjust]) cylinder(d=3.6,h=5+(adjust*2));
            if(style == "vu5") {
                translate([width,length-70,-adjust]) cylinder(d=3.6,h=5+(adjust*2));
            // prop notchs
            translate([width-5-adjust,length-65,3]) cube([5,3.5,3.5]);
            }
            if(style == "vu7") {
                translate([width,0,-adjust]) cylinder(d=3.6,h=5+(adjust*2));
            // prop notchs
            translate([width-5-adjust,length-84,3]) cube([5,3.5,3.5]);
            }
        }      
    }
}