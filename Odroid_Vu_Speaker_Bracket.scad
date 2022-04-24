/*
    HK Speaker Bracket for Vu5 and Vu7 Copyright 2021 Edward A. Kisiel
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

    20210110 Version 1.0.0  HK Speaker Bracket for Vu5 and Vu7

*/

vu_model = "vu7";   // vu5 or vu7 bracket

thick = 3;          // bracket thickness
hole1 = 3.2;        // vu attachment hole size
hole2 = 3.2;        // hk speaker hole size
vu7_left_ext = 12;  // extension for vu7 left side hole and case offset

washer_size = 8;
indent_z = 1.5;
indent_dia = 6;

$fn=90;
offset = .01;

vuspeaker(vu_model,"right",thick);
translate([-50,0,0]) mirror([90,0,0]) vuspeaker(vu_model,"left",thick);
translate([-25,0,0]) washer(washer_size,thick,hole1,indent_z,indent_dia);
translate([-25,10,0]) washer(washer_size,thick,hole1,indent_z,indent_dia);
translate([-25,20,0]) washer(washer_size,thick,hole1,indent_z,indent_dia);
translate([-25,30,0]) washer(washer_size,thick,hole1,indent_z,indent_dia);

module vuspeaker(vu_model,side,thick){

    difference() {
        union() {
            // near tab
            if(vu_model == "vu7") {
            hull() {
                translate([0,0,0]) cylinder(d=8,h=thick);
                translate([15,12,0]) cylinder(d=8,h=thick); //12.25
            }
        }
            // vu7 left extension tabs
            if(side == "left" && vu_model == "vu7") {
                hull() {
                    translate([0,0,0]) cylinder(d=8,h=thick);
                    translate([-vu7_left_ext,0,0]) cylinder(d=8,h=thick);
                }
            }          
            // vu5 left extension tabs
            if(vu_model == "vu5") {
                // left extension tabs
                hull() {
                    translate([0,12,0]) cylinder(d=8,h=thick);
                    translate([0,16,0]) cylinder(d=8,h=thick);
                }
                hull() {
                    translate([0,12,0]) cylinder(d=8,h=thick);
                    translate([15,12,0]) cylinder(d=8,h=thick); //12.25
                }
            }            
            // far tab
            if(vu_model == "vu7") {
                // left extension tabs
                hull() {
                    translate([0,114.96,0]) cylinder(d=8,h=thick);
                    translate([15,102.5,0]) cylinder(d=8,h=thick);  //102.25
                }
            }
            if(side == "left" && vu_model == "vu7") {
                hull() {
                    translate([0,114.96,0]) cylinder(d=8,h=thick);
                    translate([-vu7_left_ext,114.96,0]) cylinder(d=8,h=thick);
                }
            }
            if(vu_model == "vu5") {
                // left extension tabs
                hull() {
                    translate([0,102.96,0]) cylinder(d=8,h=thick);
                    translate([0,98.96,0]) cylinder(d=8,h=thick);
                }
                hull() {
                    translate([0,102.96,0]) cylinder(d=8,h=thick);
                    translate([15,102.5,0]) cylinder(d=8,h=thick);  //102.25
                }
            }
        
            // tie bar
            if(vu_model == "vu7") {
                translate([4,7-offset,0]) cube([3,100+offset,thick]);
                }
            else {
                translate([6,10-offset,0]) cube([3,94+offset,thick]);
                }
        }
    
        // near holes
        if(side == "left" && vu_model == "vu7") {
            translate([-vu7_left_ext,0+0,-offset]) cylinder(d=hole1,h=thick+(offset*2));
        }
        else {
            translate([0,0+15.5,-offset]) cylinder(d=hole1,h=thick+(offset*2));
        }
        // speaker holes
        translate([15,12.25,-offset]) cylinder(d=hole2,h=thick+(offset*2));
        if(side == "right" && vu_model == "vu7") {
            translate([0,0,-offset]) cylinder(d=hole1,h=thick+(offset*2));
        }        
        // far holes
        if(side == "left" && vu_model == "vu7") {
            translate([-vu7_left_ext,114.96,-offset]) cylinder(d=hole1,h=thick+(offset*2));
        }
        else {
            translate([0,114.96-15.5,-offset]) cylinder(d=hole1,h=thick+(offset*2));
        }
        // speaker holes
        translate([15,102.25,-offset]) cylinder(d=hole2,h=thick+(offset*2));
        if(side == "right" && vu_model == "vu7") {
            translate([0,114.96,-offset]) cylinder(d=hole1,h=thick+(offset*2));
        }            
    }
}

module washer(size, thick, hole, indent, indent_dia) {
    difference() {
        cylinder(d=size, h=thick);
        translate([0,0,-offset]) cylinder(d=hole, h=thick+(2*offset));
        translate([0,0,indent]) cylinder(d=indent_dia, h=thick+(2*offset));
    }
}