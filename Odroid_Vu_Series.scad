/*
    Odroid Vu Series Case Copyright 2018,2020,2021 Edward A. Kisiel
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

    20180429  version 0.1   prototype Vu7+
    20201106  version 1.0   public release
    20201112  version 1.1   added 100mm vesa mount
    20210110  version 1.2   added support for Vu7a+, Vu5a+ and Vu5+
                            added option for corner only holes for front and back
                            added hole, recessed and blind fastner options
                            fixed countersink
                            decreased M3 depth 1mm
                            added inside fillets
                            increase stand off size
                            added vu hdmi-usb cable clip
    20210120  version 1.2.1 fixed front case module hole placement for vu7 front
                            adjusted left side usb port indentation for vu5a
                            adjusted top middle hole location
    20210128  version 1.2.2 shortened vu5 bracket brace and prop for freestanding and
                            cloudshell front attachment
                            code cleanup
                          
    Vu5 Screen Dimensions : 121 x 93.31 x 15 mm Including switch and connectors)
    Viewable screen size : 108 x 64 mm (active area)

    Vu7 Screen Dimensions : 172.9 x 124.3 x 15mm Including switch and connectors)
    Viewable screen size : 153.6 x 86.64mm (active area)
*/

use <./fillets.scad>;

/* user configurable options */
mode = 0;                               // 0=platter, 1=model, 2=debug
vu_model = "vu7a+";                     // model vu7+, vu7a+, vu5+, vu5a+
front_countersink = 1;                  // 0=hole, 1=countersink, 2=recessed, 3=M3 nut, 4=blind
front_cornersonly = 1;                  // 0=all holes, 1=corner holes
back_countersink = 3;                   // 0=hole, 1=countersink, 2=recessed, 3=M3 nut, 4=blind
back_cornersonly = 0;                   // 0=all holes, 1=corner holes
back_audio = 1;                         // 0=none, 1=opening for speaker connector
button_style = 1;                       // 0=full body button, 1=standard body button, 2=short body button

/* error adjustment */
adjust_holes = 1.17;                    // hole location x-axis adjustments from drawing
adjust_buttons = .67;                   // button location x-axis adjustments from drawing

/* front configuration */
front_standoff_radius = 4.25;
front_standoff_height = 6.25;
front_holesize = 1.6;                   // front corners hole radius size
front_holesize_sbc = 1.6;               // front sbc mounts hole radius size
front_support_dia = 12;
front_support_height = 2;
front_fillet = 3;                       // front fillets size
front_corner_fillet = 6;                // front corner fillets size

/* back configuration */
back_standoff_radius = 4.25;
back_standoff_height = 7;
back_holesize = 1.6;                    // back corners hole radius size
back_holesize_sbc = 1.6;                // back sbc mounts hole radius size
back_support_dia = 12;
back_support_height = 2;
back_fillet = 3;                        // back fillets size
back_corner_fillet = 6;                 // front corner fillets

/* common case configuration */
vu5_case_x_offset = 6.5;                // for uniform front vu5=6.5, vu7=20
vu7_case_x_offset = 20;                 // for uniform front vu5=6.5, vu7=20
case_y_offset = 9.75;                   // all=9.75 minimum size
skin_thick = 2;
wall_thick = 2.5;

/* vu7 case configuration */
vu7_pcb_width = 172.90;
vu7_pcb_height = 124.27;
vu7_pcb_thick = 1.75;
vu7_width = vu7_pcb_width + vu7_case_x_offset;
vu7_height = vu7_pcb_height + case_y_offset;
vu7_front_thick = 11;
vu7_back_thick = 9;
vu7_holes = [0,0,                          // 0,0
             0,114.96,                     // 0,114.96
             164.65+adjust_holes,-.75,     // 164.83,0
             164.83+adjust_holes,114.96,   // 164.83,114.96
             164.65+adjust_holes,56.95,    // 164.83,56.95
             115.73+adjust_holes,114.96];  // 115.83,114.96

/* vu5 case configuration */
vu5_pcb_width = 121;
vu5_pcb_height = 93.31;
vu5_pcb_thick = 1.75;
vu5_width = vu5_pcb_width + vu5_case_x_offset;
vu5_height = vu5_pcb_height + case_y_offset;
vu5_front_thick = 11;
vu5_back_thick = 9;
vu5_holes = [0,0,                       // 0,0
             0,84,                      // 0,83.96
             113+adjust_holes,0,        // 113,0
             113+adjust_holes,84,       // 113,83.96
             0,0,                       // not used
             64+adjust_holes,84];       // 64,83.96

/* button data */
switch_x = 4.5;
button_x = 2;
button_y = 8;
vu7_button_loc1 = 74.18+adjust_buttons;
vu7_button_loc2 = 82.64+adjust_buttons;
vu7_button_loc3 = 91.09+adjust_buttons;
vu7_button_loc4 = 99.54+adjust_buttons;
vu5_button_loc1 = 14.04+adjust_buttons;
vu5_button_loc2 = 25.68+adjust_buttons;
vu5_button_loc3 = 37.31+adjust_buttons;
vu5_button_loc4 = 48.93+adjust_buttons;

$fn=90;
offset = 0.01;

if(mode == 0) {
    if(vu_model == "vu5+" || vu_model == "vu5a+") {
        translate([0,-15-(case_y_offset*2),0]) 
            front(vu_model, vu5_width, vu5_height, vu5_front_thick, vu5_holes, vu5_case_x_offset, case_y_offset);
        translate([0,0,0]) 
            back(vu_model, vu5_width, vu5_height, vu5_back_thick, vu5_holes, vu5_case_x_offset, case_y_offset);
    }
    if(vu_model == "vu5a+") {
        translate([23,110,0]) vubutton(button_style, vu5_back_thick);
        translate([31,110,0]) vubutton(button_style, vu5_back_thick);
        translate([39,110,0]) vubutton(button_style, vu5_back_thick);
        translate([47,110,0]) vubutton(button_style, vu5_back_thick);
    }
    if(vu_model == "vu7+" || vu_model == "vu7a+") {
        translate([0,-15-(case_y_offset*2),0]) 
            front(vu_model, vu7_width, vu7_height, vu7_front_thick, vu7_holes, vu7_case_x_offset, case_y_offset);
        translate([0,0,0]) 
            back(vu_model, vu7_width, vu7_height, vu7_back_thick, vu7_holes, vu7_case_x_offset, case_y_offset);
    }
    if(vu_model == "vu7a+") {
        translate([73,140,0]) vubutton(button_style, vu7_back_thick);
        translate([81,140,0]) vubutton(button_style, vu7_back_thick);
        translate([89,140,0]) vubutton(button_style, vu7_back_thick);
        translate([97,140,0]) vubutton(button_style, vu7_back_thick);
    }
    translate([-35,0,0]) vuhdmiclip();
    translate([-35,15,0]) vuhdmiclip();
    translate([-35,30,0]) vuhdmiclip();
    translate([-35,45,0]) vuhdmiclip();
}
if(mode == 1) {
    if(vu_model == "vu5+" || vu_model == "vu5a+") {
        translate([-60,-vu5_front_thick,10]) {
        color("DarkGrey",1) translate([0,0,0]) rotate([-90,0,0]) 
            front(vu_model, vu5_width, vu5_height, vu5_front_thick, vu5_holes, vu5_case_x_offset, case_y_offset);
        translate([0,vu5_front_thick+vu5_back_thick,0]) rotate([90,0,0]) 
            back(vu_model, vu5_width, vu5_height, vu5_back_thick, vu5_holes, vu5_case_x_offset, case_y_offset);
        }
    }
    if(vu_model == "vu7+" || vu_model == "vu7a+") {
        translate([-83,-vu7_front_thick,10]) {
        color("DarkGrey",1) translate([0,0,0]) rotate([-90,0,0]) 
            front(vu_model, vu7_width, vu7_height, vu7_front_thick, vu7_holes, vu7_case_x_offset, case_y_offset);
        translate([0,vu7_front_thick+vu7_back_thick,0]) rotate([90,0,0]) 
            back(vu_model, vu7_width, vu7_height, vu7_back_thick, vu7_holes, vu7_case_x_offset, case_y_offset);
        }
    }
}

if(mode == 2) {
//front("vu5a+", vu5_width, vu5_height, vu5_front_thick, vu5_holes, vu5_case_x_offset, case_y_offset);
//back("vu5a+", vu5_width, vu5_height, vu5_back_thick, vu5_holes, vu5_case_x_offset, case_y_offset);
front("vu7a+", vu7_width, vu7_height, vu7_front_thick, vu7_holes, vu7_case_x_offset, case_y_offset);
//back("vu7a+", vu7_width, vu7_height, vu7_back_thick, vu7_holes, vu7_case_x_offset, case_y_offset);
}


// vu shell front
module front(model, width, height, thick, holes, x_offset, y_offset) {

    difference () {
        union () {        
            difference () {
                translate([(width/2)-x_offset,-(height/2)+y_offset,(thick/2)])         
                    cube_fillet_inside([width,height,thick], 
                        vertical=[front_corner_fillet,front_corner_fillet,front_corner_fillet,
                            front_corner_fillet], top=[0,0,0,0], 
                        bottom=[front_fillet,front_fillet,front_fillet,front_fillet], $fn=90);
                if(model == "vu7+" || model == "vu7a+") {
                    translate([(width/2)-x_offset,-(height/2)+y_offset,(thick/2)+skin_thick]) 
                        cube_fillet_inside([width-(wall_thick*2),height-(wall_thick*2),thick], 
                            vertical=[front_corner_fillet-2.5,front_corner_fillet-2.5,front_corner_fillet-2.5,
                                front_corner_fillet-2.5],top=[0,0,0,0],bottom=[front_fillet,
                                    front_fillet,front_fillet,front_fillet], $fn=90);
                }
                else {
                    translate([(width/2)-x_offset,-(height/2)+y_offset,(thick/2)+skin_thick]) 
                        cube_fillet_inside([width-(wall_thick*2),height-(wall_thick*2),thick], 
                            vertical=[front_corner_fillet-2.5,front_corner_fillet-2.5,front_corner_fillet-2.5,
                                front_corner_fillet-2.5],top=[0,0,0,0],bottom=[front_fillet,
                                    0,front_fillet,0], $fn=90);
                }
                // stud cutouts for countersink
                translate([holes[0],holes[1],-offset]) 
                    cylinder(d=front_support_dia-(offset*2), h=skin_thick+(offset*2));
                translate([holes[2],-holes[3],-offset]) 
                    cylinder(d=front_support_dia-(offset*2), h=skin_thick+(offset*2));
                translate([holes[4],(holes[5]*-1),-offset]) 
                    cylinder(d=front_support_dia-(offset*2), h=skin_thick+(offset*2));    
                translate([holes[6],-holes[7],-offset]) 
                    cylinder(d=front_support_dia-(offset*2), h=skin_thick+(offset*2));
                if(front_cornersonly == 0) {
                    if(model == "vu7+" || model == "vu7a+") {
                        translate ([holes[8],-holes[9],-offset]) 
                            cylinder(d=front_support_dia-(offset*2), h=skin_thick+(offset*2));
                    }
                    translate([holes[10],-holes[11],-offset]) 
                        cylinder(d=front_support_dia-(offset*2), h=skin_thick+(offset*2));
                }               
            }           
            stud([holes[0],holes[1],0],[front_standoff_radius,front_standoff_height+skin_thick,
                front_holesize,front_support_dia,front_support_height+skin_thick,front_countersink]); 
            stud([holes[2],-holes[3],0],[front_standoff_radius,front_standoff_height+skin_thick,
                front_holesize,front_support_dia,front_support_height+skin_thick,front_countersink]);
            stud([holes[4],(holes[5]*-1),0],[front_standoff_radius,front_standoff_height+skin_thick,
                front_holesize,front_support_dia,front_support_height+skin_thick,front_countersink]);
            stud([holes[6],-holes[7],0],[front_standoff_radius,front_standoff_height+skin_thick,
                front_holesize,front_support_dia,front_support_height+skin_thick,front_countersink]);
            if(model == "vu7+" || model == "vu7a+") {
                stud ([holes[8],-holes[9],0],[front_standoff_radius,front_standoff_height+skin_thick,
                    front_holesize_sbc,front_support_dia,front_support_height+skin_thick,
                        front_countersink]);
            }
            stud([holes[10],-holes[11],0],[front_standoff_radius,front_standoff_height+skin_thick,
                front_holesize_sbc,front_support_dia,front_support_height+skin_thick,front_countersink]);
            // button support
            if(model == "vu7a+") {
                translate([vu7_button_loc1-1,-122-offset,skin_thick]) cube([2,8+skin_thick,thick-skin_thick]);
                translate([vu7_button_loc2-1,-122-offset,skin_thick]) cube([2,8+skin_thick,thick-skin_thick]);
                translate([vu7_button_loc3-1,-122-offset,skin_thick]) cube([2,8+skin_thick,thick-skin_thick]);
                translate([vu7_button_loc4-1,-122-offset,skin_thick]) cube([2,8+skin_thick,thick-skin_thick]);
            }
            if(model == "vu5a+") {
                translate([vu5_button_loc1-adjust_buttons,-91-offset,skin_thick]) 
                    cube([2,8+skin_thick,thick-skin_thick]);
                translate([vu5_button_loc2-adjust_buttons,-91-offset,skin_thick]) 
                    cube([2,8+skin_thick,thick-skin_thick]);
                translate([vu5_button_loc3-adjust_buttons,-91-offset,skin_thick]) 
                    cube([2,8+skin_thick,thick-skin_thick]);
                translate([vu5_button_loc4-adjust_buttons,-91-offset,skin_thick]) 
                    cube([2,8+skin_thick,thick-skin_thick]);
            }
        }
        // common usb indent
        translate([holes[6]+7,-holes[7]+6.25,skin_thick+9+offset]) microusb();
        translate([holes[6]+7-(wall_thick/2),-holes[7]+7.5,skin_thick+10]) rotate([0,90,0]) {
        hull() {
            cylinder(d=7,h=1.5);
            translate([0,6,0]) cylinder(d=7,h=1.5); }
        }           
        // audio jack opening
        translate([holes[6]+3,-holes[7]+67.25,skin_thick+11.5]) rotate([0,90,0]) 
            cylinder(d=5.25, h=skin_thick+3);      
        // vu7+ and vu7a+ common
        if(model == "vu7+" || model == "vu7a+") {
            // screen cutout    
            translate([-1.5,-105,-1]) cube([156,88,thick+2]);
            // clearence cutout
            translate([158,-62,skin_thick]) cube([4,12,front_support_height+front_standoff_height]);
        }
        // vu5+ and vu5a+ common
        if(model == "vu5+" || model == "vu5a+") {
            // screen cutout    
            translate([1.5,-76.5,-1]) cube([111,66,thick+2]);
            // lcd fit trim
            translate([holes[0]-4,-holes[1]-6.47,skin_thick]) cube([14,4,thick]);
            translate([holes[2]-4,-holes[3]+2.47,skin_thick]) cube([14,4,thick]);
            translate([holes[4]-5.67,-holes[5]-6.47,skin_thick]) cube([10,4,thick]);
            translate([holes[6]-5.67,-holes[7]+2.47,skin_thick]) cube([10,4,thick]);
            translate([holes[10]-5.5,-holes[11]+2.47,skin_thick]) cube([11,4,thick]);
        }
        // vu5a+ only
        if(model == "vu5a+") {
            // usb indent
            translate([-x_offset-.25,holes[1]-13.5,skin_thick+10.5]) rotate([0,90,0])
            hull() {
                cylinder(d=7,h=1.5);
                translate([0,6,0]) cylinder(d=7,h=1.5); }
        }
        // vu7a+ only
        if(model == "vu7a+") {
            // lower micro usb
            translate([holes[6]+7,-holes[7]+78.25,skin_thick+9+offset]) microusb();
            translate([holes[6]+7-(wall_thick/2),-holes[7]+79.5,skin_thick+10]) rotate([0,90,0]) {
                hull() {
                    cylinder(d=7,h=1.5);
                    translate([0,6,0]) cylinder(d=7,h=1.5);
                }
            }
        }
        // clean outside of fillets
        translate([(width/2)-x_offset, -(height/2)+y_offset, (thick/2)])     
          cube_negative_fillet([width,height,thick], radius=-1, vertical=[front_corner_fillet,
              front_corner_fillet,front_corner_fillet,front_corner_fillet], top=[0,0,0,0], 
                  bottom=[front_fillet,front_fillet,front_fillet,front_fillet], $fn=90);
    }
}

// vu shell back
module back(model, width, height, thick, holes, x_offset, y_offset) {

    difference () {
        union () {        
            difference () {
                translate([(width/2)-x_offset, (height/2)-y_offset, (thick/2)])
                    cube_fillet_inside([width,height,thick], vertical=[back_corner_fillet,
                        back_corner_fillet,back_corner_fillet,back_corner_fillet], top=[0,0,0,0],
                            bottom=[back_fillet,back_fillet,back_fillet,back_fillet], $fn=60);
                translate([(width/2)-x_offset, (height/2)-y_offset, (thick/2)+skin_thick])
                    cube_fillet_inside([width-(wall_thick*2), height-(wall_thick*2), 
                        thick], vertical=[back_corner_fillet-2.5,back_corner_fillet-2.5,back_corner_fillet-2.5,
                            back_corner_fillet-2.5], top=[0,0,0,0], bottom=[back_fillet,back_fillet,
                                back_fillet,back_fillet], $fn=60);
                // vent cut outs
                for (r=[4:55:width-20-x_offset]) {
                    for (c=[6:4:height-25]) {
                        translate ([r,c,-1]) cube([45,2,thick+2]);
                    }
                }
                // stud cutouts for countersink
                translate([holes[0],holes[1],-offset]) 
                    cylinder(d=back_support_dia-(offset*2), h=skin_thick+(offset*2));
                translate([holes[2],holes[3],-offset]) 
                    cylinder(d=back_support_dia-(offset*2), h=skin_thick+(offset*2));         
                translate([holes[4],holes[5],-offset]) 
                    cylinder(d=back_support_dia-(offset*2), h=skin_thick+(offset*2));
                translate([holes[6],holes[7],-offset]) 
                    cylinder(d=back_support_dia-(offset*2), h=skin_thick+(offset*2));
                if(back_cornersonly == 0) {
                    if(model == "vu7+" || model == "vu7a+") {
                        translate([holes[8],holes[9],-offset]) 
                            cylinder(d=back_support_dia-(offset*2), h=skin_thick+(offset*2));
                    }
                    translate([holes[10],holes[11],-offset]) 
                        cylinder(d=back_support_dia-(offset*2), h=skin_thick+(offset*2));
                } 
            }
            // rear speaker connector support
            if(back_audio == 1 && model == "vu7a+") {
                translate([53,98,0]) cube([15,10,skin_thick]);
            }           
            if(back_audio == 1 && model == "vu5a+") {
                translate([81,10,0]) cube([10,16,skin_thick]);
            }           
            // pcb mount points       
            stud([holes[0],holes[1],0],[back_standoff_radius,back_standoff_height+skin_thick,
                back_holesize,back_support_dia,back_support_height+skin_thick,back_countersink]);
            stud([holes[2],holes[3],0],[back_standoff_radius,back_standoff_height+skin_thick,
                back_holesize,back_support_dia,back_support_height+skin_thick,back_countersink]);
            stud([holes[4],holes[5],0],[back_standoff_radius,back_standoff_height+skin_thick,
                back_holesize,back_support_dia,back_support_height+skin_thick,back_countersink]);
            stud([holes[6],holes[7],0],[back_standoff_radius,back_standoff_height+skin_thick,
                back_holesize,back_support_dia,back_support_height+skin_thick,back_countersink]);
            if(model == "vu7+" || model == "vu7a+") {
                stud([holes[8],holes[9],0],[back_standoff_radius,back_standoff_height+skin_thick,
                    back_holesize,back_support_dia,back_support_height+skin_thick,back_countersink]);
            }
            stud([holes[10],holes[11],0],[back_standoff_radius,back_standoff_height+skin_thick,
                back_holesize,back_support_dia,back_support_height+skin_thick,back_countersink]);
            // 100mm vesa mount studs
            if(model == "vu7+" || model == "vu7a+") {
                stud([(holes[4]/2)-50,(holes[3]/2)-50,0],[6,6,back_holesize,18,4,0]);
                stud([(holes[4]/2)+50,(holes[3]/2)-50,0],[6,6,back_holesize,18,4,0]);
                stud([(holes[4]/2)-50,(holes[3]/2)+50,0],[6,6,back_holesize,18,4,0]);
                stud([(holes[4]/2)+50,(holes[3]/2)+50,0],[6,6,back_holesize,18,4,0]);
            }
            // 75mmx50mm vesa mount studs
           if(model == "vu5+" || model == "vu5a+") {
                stud([(holes[4]/2)-37.5,(holes[3]/2)-25,0],[6,6,back_holesize,18,4,0]);
                stud([(holes[4]/2)+37.5,(holes[3]/2)-25,0],[6,6,back_holesize,18,4,0]);
                stud([(holes[4]/2)-37.5,(holes[3]/2)+25,0],[6,6,back_holesize,18,4,0]);
                stud([(holes[4]/2)+37.5,(holes[3]/2)+25,0],[6,6,back_holesize,18,4,0]);
            }
            // button support
            if(model == "vu7a+") {
                translate([vu7_button_loc1-5.25,112,skin_thick]) cube([2,8+wall_thick,thick-skin_thick]);
                translate([vu7_button_loc2-5.25,112,skin_thick]) cube([2,8+wall_thick,thick-skin_thick]);
                translate([vu7_button_loc3-5.25,112,skin_thick]) cube([2,8+wall_thick,thick-skin_thick]);
                translate([vu7_button_loc4-5.25,112,skin_thick]) cube([2,8+wall_thick,thick-skin_thick]);
                translate([vu7_button_loc4+3.25,112,skin_thick]) cube([2,8+wall_thick,thick-skin_thick]);
            }
            if(model == "vu5a+") {
                translate([vu5_button_loc1-5.25,81,skin_thick]) cube([2,8+wall_thick,thick-skin_thick]);
                translate([vu5_button_loc1+3.25,81,skin_thick]) cube([2,8+wall_thick,thick-skin_thick]);
                translate([vu5_button_loc2-5.25,81,skin_thick]) cube([2,8+wall_thick,thick-skin_thick]);
                translate([vu5_button_loc2+3.25,81,skin_thick]) cube([2,8+wall_thick,thick-skin_thick]);
                translate([vu5_button_loc3-5.25,81,skin_thick]) cube([2,8+wall_thick,thick-skin_thick]);
                translate([vu5_button_loc3+3.25,81,skin_thick]) cube([2,8+wall_thick,thick-skin_thick]);
                translate([vu5_button_loc4-5.25,81,skin_thick]) cube([2,8+wall_thick,thick-skin_thick]);
                translate([vu5_button_loc4+3.25,81,skin_thick]) cube([2,8+wall_thick,thick-skin_thick]);
            }
        }
        // 100mm vesa mount holes
        if(model == "vu7+" || model == "vu7a+") {
            translate([(holes[4]/2)-50,(holes[3]/2)-50,-.01]) 
                cylinder(r=back_holesize, h=back_standoff_height+1);
            translate([(holes[4]/2)+50,(holes[3]/2)-50,-.01]) 
                cylinder(r=back_holesize, h=back_standoff_height+1);
            translate([(holes[4]/2)-50,(holes[3]/2)+50,-.01]) 
                cylinder(r=back_holesize, h=back_standoff_height+1);
            translate([(holes[4]/2)+50,(holes[3]/2)+50,-.01]) 
                cylinder(r=back_holesize, h=back_standoff_height+1);
        }
        // 75x50mm vesa mount holes
        if(model == "vu5+" || model == "vu5a+") {
            translate([(holes[4]/2)-37.5,(holes[3]/2)-25,-.01]) 
                cylinder(r=back_holesize, h=back_standoff_height+1);
            translate([(holes[4]/2)+37.5,(holes[3]/2)-25,-.01]) 
                cylinder(r=back_holesize, h=back_standoff_height+1);
            translate([(holes[4]/2)-37.5,(holes[3]/2)+25,-.01]) 
                cylinder(r=back_holesize, h=back_standoff_height+1);
            translate([(holes[4]/2)+37.5,(holes[3]/2)+25,-.01]) 
                cylinder(r=back_holesize, h=back_standoff_height+1);
        }
        // 100mm vesa nut countersink
        if(model == "vu7+" || model == "vu7a+") {
            translate([(holes[4]/2)-50,(holes[3]/2)-50,2]) cylinder(r=3.3,h=5,$fn=6);
            translate([(holes[4]/2)+50,(holes[3]/2)-50,2]) cylinder(r=3.3,h=5,$fn=6);
            translate([(holes[4]/2)-50,(holes[3]/2)+50,2]) cylinder(r=3.3,h=5,$fn=6);
            translate([(holes[4]/2)+50,(holes[3]/2)+50,2]) cylinder(r=3.3,h=5,$fn=6);
        }
        // 75mmx50mm vesa nut countersink
        if(model == "vu5+" || model == "vu5a+") {
            translate([(holes[4]/2)-37.5,(holes[3]/2)-25,2]) cylinder(r=3.3,h=5,$fn=6);
            translate([(holes[4]/2)+37.5,(holes[3]/2)-25,2]) cylinder(r=3.3,h=5,$fn=6);
            translate([(holes[4]/2)-37.5,(holes[3]/2)+25,2]) cylinder(r=3.3,h=5,$fn=6);
            translate([(holes[4]/2)+37.5,(holes[3]/2)+25,2]) cylinder(r=3.3,h=5,$fn=6);
        }
        // common micro usb opening
        translate([holes[6]+7,holes[7]-15.25,skin_thick+5+offset]) microusb();
        translate([holes[6]+7-(wall_thick/2),holes[7]-13.5,skin_thick+6]) rotate([0,90,0]) {
            hull() {
                cylinder(d=7,h=1.5);
                translate([0,6,0]) cylinder(d=7,h=1.5);
            }
        }       
        // common hdmi opening
        translate([holes[6]+8,holes[7]-36.25,skin_thick+1])
            translate([-11.5,0,5.5]) rotate([180,0,90]) {
            union() { 
                difference() {
                    color("silver") translate([0,0,0]) cube([15.5, 11.5, 5.5]);
                    color("silver") translate([0,-.2,0]) rotate ([-90,0,0]) 
                        cylinder(d=3, h=13.5,$fn=30);
                    color("silver") translate([15.5,-.2,0]) rotate ([-90,0,0]) 
                        cylinder(d=3, h=13.5,$fn=30);
                }
                color("silver") translate([1.5,0,-.99]) cube([12.5, 11.5, 1]);
            }
        }       
        // vu5+ and vu7+ switch opening
        if(model == "vu7+" || model =="vu5+") {
            translate([holes[6]+4,holes[7]-53,skin_thick]) cube([thick*2,14,thick]);
        }
        // vu5a+ and vu7a+ common holes
        if(model == "vu7a+" || model =="vu5a+") {
            // button opening
            translate([holes[6]+2.5,holes[7]-48,skin_thick+2.75]) rotate([0,90,0])
                cylinder(d=4, h=skin_thick+4);
            // internal button indent
            translate([holes[6]-3.25,holes[7]-52.25,skin_thick+8]) rotate([0,90,0]) cube([8.5,9,8]);
            // audio jack opening
            translate([holes[6]+3,holes[7]-67.25,skin_thick+4.5]) rotate([0,90,0]) 
                cylinder(d=5.25, h=skin_thick+3);
            // internal audio jack indent
            translate([holes[6]-8.25,holes[7]-71.75,skin_thick+8]) rotate([0,90,0]) cube([8.5,9,13]);
            // vu7a+ only holes
            if(model == "vu7a+") {
                // micro usb opening
                translate([holes[6]+7,holes[7]-87.25,skin_thick+5+offset]) microusb();
                 translate([holes[6]+7-(wall_thick/2),holes[7]-85.5,skin_thick+6]) rotate([0,90,0]) {
                    hull() {
                        cylinder(d=7,h=1.5);
                        translate([0,6,0]) cylinder(d=7,h=1.5);
                    }
                }
                // vu7a+ button holes
                translate([vu7_button_loc1,123,skin_thick+5.5+offset]) rotate([-90,0,0])
                    cube_fillet_inside([switch_x+.5,wall_thick+.5,wall_thick+.5], 
                        vertical=[1,1,1,1], top=[0,0,0,0], bottom=[0,0,0,0], $fn=60);
                translate([vu7_button_loc2,123,skin_thick+5.5+offset]) rotate([-90,0,0])
                    cube_fillet_inside([switch_x+.5,wall_thick+.5,wall_thick+.5], 
                        vertical=[1,1,1,1], top=[0,0,0,0], bottom=[0,0,0,0], $fn=60);
                translate([vu7_button_loc3,123,skin_thick+5.5+offset]) rotate([-90,0,0])         
                    cube_fillet_inside([switch_x+.5,wall_thick+.5,wall_thick+.5], 
                        vertical=[1,1,1,1], top=[0,0,0,0], bottom=[0,0,0,0], $fn=60);
                translate([vu7_button_loc4,123,skin_thick+5.5+offset]) rotate([-90,0,0]) 
                    cube_fillet_inside([switch_x+.5,wall_thick+.5,wall_thick+.5], 
                        vertical=[1,1,1,1], top=[0,0,0,0], bottom=[0,0,0,0], $fn=60);
                // speaker connection cutout
                if(back_audio == 1) {
                    translate([53,100.75,-offset]) cube([11,6,12]);
                }
            }       
            // vu5a+ button holes
            if(model == "vu5a+") {
                // top button holes
                translate([vu5_button_loc1,92,skin_thick+5.5+offset]) rotate([-90,0,0])
                    cube_fillet_inside([switch_x+.5,wall_thick+.5,wall_thick+.5], 
                        vertical=[1,1,1,1], top=[0,0,0,0], bottom=[0,0,0,0], $fn=60);
                translate([vu5_button_loc2,92,skin_thick+5.5+offset]) rotate([-90,0,0])
                    cube_fillet_inside([switch_x+.5,wall_thick+.5,wall_thick+.5], 
                        vertical=[1,1,1,1], top=[0,0,0,0], bottom=[0,0,0,0], $fn=60);
                translate([vu5_button_loc3,92,skin_thick+5.5+offset]) rotate([-90,0,0])         
                    cube_fillet_inside([switch_x+.5,wall_thick+.5,wall_thick+.5], 
                        vertical=[1,1,1,1], top=[0,0,0,0], bottom=[0,0,0,0], $fn=60);
                translate([vu5_button_loc4,92,skin_thick+5.5+offset]) rotate([-90,0,0]) 
                    cube_fillet_inside([switch_x+.5,wall_thick+.5,wall_thick+.5], 
                        vertical=[1,1,1,1], top=[0,0,0,0], bottom=[0,0,0,0], $fn=60);
                // micro usb opening
                translate([-x_offset-wall_thick+offset,holes[1]+5.5,skin_thick+4.5+offset]) microusb();
                translate([-x_offset-.25,holes[1]+7.5,skin_thick+5.5]) rotate([0,90,0])
                hull() {
                    cylinder(d=7,h=1.5);
                    translate([0,6,0]) cylinder(d=7,h=1.5); }
                // speaker connection cutout
                if(back_audio == 1) {
                    translate([84.25,12,-offset]) cube([6,11,12]);
                }
            }       
        }
        // clean outside of fillets
        translate([(width/2)-x_offset, (height/2)-y_offset, (thick/2)])     
          cube_negative_fillet([width,height,thick], radius=-1, vertical=[back_corner_fillet,
              back_corner_fillet,back_corner_fillet,back_corner_fillet], top=[0,0,0,0], 
                  bottom=[back_fillet,back_fillet,back_fillet,back_fillet], $fn=90);        
    }
    // button support
    if(model == "vu7a+") {
        if(mode == 1) {
            color("Black",1) translate([vu7_button_loc1+1,111,thick]) rotate([0,180,0]) 
                vubutton(button_style, thick);
            color("Black",1) translate([vu7_button_loc2+1,111,thick]) rotate([0,180,0]) 
                vubutton(button_style, thick);
            color("Black",1) translate([vu7_button_loc3+1,111,thick]) rotate([0,180,0]) 
                vubutton(button_style, thick);
            color("Black",1) translate([vu7_button_loc4+1,111,thick]) rotate([0,180,0]) 
                vubutton(button_style, thick);
        }
    }
    if(model == "vu5a+") {
        if(mode == 1) {
            color("Black",1) translate([vu5_button_loc1+1,80,thick]) rotate([0,180,0]) 
                vubutton(button_style, thick);
            color("Black",1) translate([vu5_button_loc2+1,80,thick]) rotate([0,180,0]) 
                vubutton(button_style, thick);
            color("Black",1) translate([vu5_button_loc3+1,80,thick]) rotate([0,180,0]) 
                vubutton(button_style, thick);
            color("Black",1) translate([vu5_button_loc4+1,80,thick]) rotate([0,180,0]) 
                vubutton(button_style, thick);
        }
    }
}

// stud standoff
module stud (loc, standoff){
    x = loc[0];
    y = loc[1];
    z = loc[2];
    radius = standoff[0];
    height = standoff[1];
    holesize = standoff[2];
    supportsize = standoff[3];
    supportheight = standoff[4];
    sink = standoff[5];
    offset = 0.01;
    
    translate([x,y,z]) 
    difference (){ 
        union () {
            cylinder(r=radius,h=height,$fn=6);
            cylinder(r=(supportsize/2),h=supportheight,$fn=60);
        }
        // hole
        if( sink <= 3) {
        translate([0,0,-offset]) cylinder(r=holesize, h=height+(offset*2),$fn=90);
        }
        // countersink hole
        if(sink == 1) {
            translate([0,0,-offset]) cylinder(d1=6, d2=(holesize*2), h=2.5);
        }
        // recessed hole
        if(sink == 2) {
            translate([0,0,-offset]) cylinder(d=6, h=3);
        }
        // nut holder
        if(sink == 3) {
            translate([0,0,-offset]) cylinder(r=3.3,h=4,$fn=6);     
        }
        // blind hole
        if(sink == 4) {
            translate([0,0,2]) cylinder(r=holesize, h=height,$fn=90);
        }
    }
}

   
// sheet
module sheet(size, radius) {
    x = size[0];
    y = size[1];
    z = size[2];   
    linear_extrude(height=z)
    hull() {
        translate([0+radius ,0+radius, 0]) circle(r=radius);	
        translate([0+radius, y-radius, 0]) circle(r=radius);	
        translate([x-radius, y-radius, 0]) circle(r=radius);	
        translate([x-radius, 0+radius, 0]) circle(r=radius);
    }
}
    

// micro-usb cutout
module microusb() {
    rotate([90,0,90])
    hull() {
        translate([7,1,-5]) cylinder(d=3,h=10);
        translate([2,1,-5]) cylinder(d=3,h=10);
    }
}

module vubutton(button_style, thick){
    style = button_style;
    thick = thick; 
    if(style == 0) {
    translate([0,0,0]) cube([button_x,10,thick-skin_thick]);
    translate([1,12.5-offset,1.5]) rotate([-90,0,0])
        cube_fillet_inside([switch_x,3+(offset*2),5], 
            vertical=[1,1,1,1], top=[0,0,0,0], bottom=[0,0,0,0], $fn=60);
    translate([-2,3,0]) cube([6,7,thick-skin_thick-3]);        
    }
    if(style == 1) {
    translate([0,0,0]) cube([button_x,9,thick-skin_thick]);
    translate([1,12-offset,1.5]) rotate([-90,0,0])
        cube_fillet_inside([switch_x,3+(offset*2),6], 
            vertical=[1,1,1,1], top=[0,0,0,0], bottom=[0,0,0,0], $fn=60);
    translate([-2,3,0]) cube([6,6,thick-skin_thick-3]);        
    }
    if(style == 2) {
        translate([0,0,0]) cube([button_x,7,thick-skin_thick]);
        translate([1,11-offset,1.5]) rotate([-90,0,0])
            cube_fillet_inside([switch_x,3+(offset*2),8], 
                vertical=[1,1,1,1], top=[0,0,0,0], bottom=[0,0,0,0], $fn=60);
        translate([-2,3,0]) cube([6,4,thick-skin_thick-3]);
    }
}

module vuhdmiclip(){
    wall_thick = 2;
    hdmi_width = 13;
    hdmi_thick = 3.5;
    hdmi_height = 4;
    usb_dia = 4;
    
    difference() {
        union() {
            translate([0,0,0]) 
                cube_fillet_inside([hdmi_width+(wall_thick*2),hdmi_thick+(wall_thick*2),hdmi_height],
                vertical=[1,1,1,1], top=[0,0,0,0], bottom=[0,0,0,0], $fn=60);
            translate([0,(hdmi_thick+wall_thick)/2,0]) 
                cylinder(d=usb_dia+(wall_thick*1.5), h=hdmi_height, center=true);
        }
        translate([wall_thick/2,0,0])
            cube_fillet_inside([hdmi_width+wall_thick+offset,hdmi_thick,hdmi_height+(wall_thick*2)],
                vertical=[1,1,1,1], top=[0,0,0,0], bottom=[0,0,0,0], $fn=60);
        translate([0,(hdmi_thick+wall_thick)/2,0]) 
            cylinder(d=usb_dia, h=hdmi_height*2, center=true);
    }
}
