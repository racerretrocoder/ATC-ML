####    Player Mode ATC ####
####  Syd Adams , Csaba Halász  ####

var TWR_gnd = props.globals.getNode("/position/ground-elev-ft",1);						## gnd 829 Ground/Airport Height above SeaLevel (FGFS)
var TWR_agl = props.globals.getNode("/sim/tower/altitude-agl-ft",1);					## agl  54 Pilot Height above Ground-Level (used as TWR)
var TWR_alt = props.globals.getNode("/sim/tower/altitude-ft",1);						## alt 883 Pilot Height above SeaLevel
var TWR_lat = props.globals.getNode("/sim/tower/latitude-deg",1);
var TWR_lon = props.globals.getNode("/sim/tower/longitude-deg",1);
var TWR_RWin_ICAO = props.globals.getNode("/sim/tower/TWR-RWin-ICAO"," ");
var TWR_RWin_ALT = props.globals.getNode("/sim/tower/TWR-RWin-ALT",1);
var ATC_heading = props.globals.getNode("/orientation/heading-deg",1);
var ATC_pitch = props.globals.getNode("/orientation/pitch-deg",1);
var ATC_roll = props.globals.getNode("/orientation/roll-deg",1);
var ATC_fov = props.globals.getNode("/sim/current-view/field-of-view",1);
var ATC_offset_x = props.globals.getNode("/sim/current-view/x-offset-m",1);
var ATC_offset_y = props.globals.getNode("/sim/current-view/y-offset-m",1);
var ATC_offset_z = props.globals.getNode("/sim/current-view/z-offset-m",1);
var ATC_target_brg = props.globals.getNode("/sim/current-view/goal-heading-offset-deg",1);
var ATC_target_pitch = props.globals.getNode("/sim/current-view/goal-pitch-offset-deg",1);
var ATC_target_id = props.globals.getNode("/sim/atc/target-id",1);
var ATC_target_alt = props.globals.getNode("/sim/atc/target-alt",1);
var ATC_target_range = props.globals.getNode("/sim/atc/target-range",1);
var ATC_target_speed = props.globals.getNode("/sim/atc/target-kt",1);
var ATC_target_hdg = props.globals.getNode("/sim/atc/target-hdg",1);
var ATC_num =props.globals.getNode("/sim/atc/target-number",1);
var ATC_panel_visibility = props.globals.getNode("/sim/panel/visibility", 1);
setprop("/sim/panel/visibility", 1);
var RADAR = props.globals.getNode("/instrumentation/radar", 1);
var RADAR_max = props.globals.getNode("/instrumentation/radar/reference-range-nm", 1);
var RADAR_rotate = props.globals.getNode("/instrumentation/radar/display-controls/rotate", 1);
var Set_orientation = props.globals.getNode("/orientation/heading-deg", 1);
var Localizer_display = props.globals.getNode("/sim/atc/localizer-display", 1);
var Localizer_offset = props.globals.getNode("/sim/atc/localizer-offset", 1);
var Localizer_offset_display = props.globals.getNode("/sim/atc/localizer-offset-display", 1);
var Localizer_heading_deg = props.globals.getNode("/sim/atc/localizer-heading-deg", 1);
var follow = props.globals.getNode("/sim/atc/tracking", 1);
var Wind_reported = props.globals.getNode("/environment/wind-from-heading-deg", 1);
var Wind_displayed = props.globals.getNode("/sim/atc/wind-from-display", 1);
var Mag_offset = props.globals.getNode("/environment/magnetic-variation-deg", 1);

# new commmon varibles -- je
var CMD_DELETE = props.globals.getNode("/sim/gui/dialogs/ATC-ML/ATC-MPinRW/DELETE", " ");
CMD_DELETE.setValue("no");
var CMD_target_range = props.globals.getNode("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-target-range", " ");
CMD_target_range.setValue(0);
var CMD_target = props.globals.getNode("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-target", " ");
CMD_target.setValue(" ");
var CMD_short = props.globals.getNode("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-short", " ");
var CMD_long = props.globals.getNode("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-long", " ");
var CMD_add = props.globals.getNode("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-add", " ");
var CMD_properties = props.globals.getNode("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-properties", " ");
var MP_Status = props.globals.getNode("/sim/gui/dialogs/ATC-ML/ATC-MP/MP-Status", " ");
var MP_Status_temp = props.globals.getNode("/sim/gui/dialogs/ATC-ML/ATC-MP/MP-Status-temp", " ");
var CMD_job = props.globals.getNode("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-job", " ");
setprop("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-job", "ATC");
var CMD_UID = props.globals.getNode("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-UID","");
var CMD_UID_a = props.globals.getNode("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-UID_a","");
var CMD_UID_b = props.globals.getNode("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-UID_b","");
var CMD_UID_c = props.globals.getNode("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-UID_c","");
var CMD_UID_d = props.globals.getNode("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-UID_d","");
CMD_UID_d.setValue(" ");
var CMD_UID_sa = props.globals.getNode("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-UID_sa",1);
var CMD_UID_sb = props.globals.getNode("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-UID_sb",1);
var CMD_UID_sc = props.globals.getNode("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-UID_sc",1);
var CMD_UID_sd = props.globals.getNode("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-UID_sd",1);
CMD_UID_sa.setBoolValue(0);
CMD_UID_sb.setBoolValue(0);
CMD_UID_sc.setBoolValue(1);	## TBD: just bypassing setting (a=1) for now
CMD_UID_sd.setBoolValue(0);
setprop("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-UID_sb",0);
setprop("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-UID_sc",0);
setprop("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-UID_sd",0);
var CMD_UID_sel = props.globals.getNode("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-UID_sd"," ");
var MP_Status_temp = props.globals.getNode("/sim/gui/dialogs/ATC-ML/ATC-MP/MP-Status-temp", " ");
var CMD_L2 = props.globals.getNode("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-languages/l2", " ");
CMD_L2.setValue("");
var CMD_L3 = props.globals.getNode("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-languages/l3", " ");
CMD_L3.setValue("");
var CMD_lsum = props.globals.getNode("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-languages/lsum", " ");
CMD_lsum.setValue("  en");
var CMD_compose = props.globals.getNode("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-compose", " ");
var chat_node = props.globals.getNode("/sim/multiplay/chat", "");
var CMD_APname = props.globals.getNode("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-APname", " ");
var CMD_APalt = props.globals.getNode("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-APalt", 1);
if (getprop("/sim/tower/airport-id")=="") {
	CMD_APname.setValue(" ");
	CMD_APalt.setValue(0);
} else {	
	CMD_APname.setValue(airportinfo(getprop("/sim/tower/airport-id")).name);
	CMD_APalt.setValue(airportinfo(getprop("/sim/tower/airport-id")).elevation*3.281);
}
var CMD_Time = props.globals.getNode("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-Time", " ");
var CMD_TimeS = props.globals.getNode("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-TimeS", 1);
CMD_TimeS.setIntValue(0);
var CMD_TimeH = props.globals.getNode("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-TimeH", 1);
CMD_TimeH.setIntValue(0);
var CMD_TimeM = props.globals.getNode("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-TimeM", 1);
CMD_TimeM.setIntValue(0);
var RADD = props.globals.getNode("/sim/gui/dialogs/ATC-ML/ATC-MPinRW", 1);
var RAD_ICAO = props.globals.getNode("/sim/gui/dialogs/ATC-ML/ATC-MPinRW/RAD-ICAO", " ");
RAD_ICAO.setValue(" ");
var RAD_new = props.globals.getNode("/sim/gui/dialogs/ATC-ML/ATC-MPinRW/RAD-new", 1);
var RAD_old = props.globals.getNode("/sim/gui/dialogs/ATC-ML/ATC-MPinRW/RAD-old", 1);
var ICAO_Status = props.globals.getNode("/sim/gui/dialogs/ATC-ML/ATC-MPinRW/ICAO-Status", " ");
ICAO_Status.setValue("actual");
var LANGdat = resolvepath ("Aircraft/ATC-ML/ATCmsg/Languages.txt");
var LANGfile = "";

# new Dialog-Modules --   je
gui.Dialog.new("/sim/gui/dialogs/ATC-ML/ATC-MP/dialog", "Aircraft/ATC-ML/ATC-MP.xml");
gui.Dialog.new("/sim/gui/dialogs/ATC-ML/ATC-MPinMsg/dialog", "Aircraft/ATC-ML/ATC-MPinMsg.xml");
gui.Dialog.new("/sim/gui/dialogs/ATC-ML/ATC-MPinRW/dialog", "Aircraft/ATC-ML/ATC-MPinRW.xml");
gui.Dialog.new("/sim/gui/dialogs/ATC-ML/ATC-MPinRWcmp/dialog", "Aircraft/ATC-ML/ATC-MPinRWcmp.xml");
gui.Dialog.new("/sim/gui/dialogs/ATC-ML/ATC-MPCMDsel/dialog", "Aircraft/ATC-ML/ATC-MPCMDsel.xml");
gui.Dialog.new("/sim/gui/dialogs/ATC-ML/ATC-MPlanguage/dialog", "Aircraft/ATC-ML/ATC-MPlanguage.xml");

var FDM_ON = 0;
var Pout = "";
var CMD_NR = 0;
var PoutS = 0;
var ATCdir = getprop("/sim/aircraft-dir/");
var RadarDat = getprop("/sim/fg-home")~"/ATC-ML_RadarDat.log";
var FontDat = getprop("/sim/fg-home")~"/ATC-ML_FontDat.log";
var RADfile = "";
var target = "";
var target_coords = geo.Coord.new();
var tower_coords = geo.Coord.new();
tower_coords.set_latlon(TWR_lat.getValue(), TWR_lon.getValue(), TWR_alt.getValue());
var Tnm=0;
var SETTY = "";
var A = "";
var AZ = 0;
var ss="d";

####################
var do_init = func {
	print("-------Initialize ATC-ML");
    props.globals.getNode("/sim/current-view/view-number",1).setValue(100);
	setprop("/sim/tower/auto-position",0);		#allow change of position

		update_ICAO(getprop("/sim/tower/airport-id"));

    ATC_num.setIntValue(0);
    ATC_target_id.setValue("");
    ATC_target_alt.setDoubleValue(0);
    ATC_target_speed.setDoubleValue(0);
    ATC_target_hdg.setDoubleValue(0);
    follow.setBoolValue("true");
    Localizer_display.setBoolValue("true");
    Localizer_offset.setIntValue(0);
    Localizer_offset_display.setIntValue(0);
    Localizer_heading_deg.setIntValue(0);
    aircraft.data.add("/instrumentation/radar/font");
    RADAR_rotate.setBoolValue("true");
    Set_orientation.setValue(Mag_offset.getValue());
	RADAR_max.setValue(128);						##je 100212
	MP_Status.setValue("off");
	MP_Status_temp.setValue("off");
	############# Load the available Language Codes:
	LANGfile = call(func io.open(LANGdat, "r"), nil, var err=[]);
	if (size(err))	{
		print("### ERROR ###: ",LANGdat," not found");
		print("### You must create that ",LANGdat,"-file yourselfe - picking up all language-codes available");
	} else {
		props.globals.getNode("/sim/gui/dialogs/ATC-ML/ATC-MPlanguage/dialog/combo").removeChildren("value");		
		var (line, line1) = ("00", "");
		for(var i = 0; line != nil; i += 1) {
			line = io.readln(LANGfile);
			if (line != nil) {
				setprop("/sim/gui/dialogs/ATC-ML/ATC-MPlanguage/dialog/combo/value[" ~ i ~ "]", line);
				setprop("/sim/gui/dialogs/ATC-ML/ATC-MPlanguage/dialog/combo[1]/value[" ~ i ~ "]", line);	
		}	}
		io.close(LANGfile);
	}
    FDM_ON =1;
	getFontSettings();
	update_UID();
	update_ICAO(getprop("/sim/tower/airport-id"));
	getLanguage();
    settimer(update_systems, 1);
}

setlistener("/sim/signals/fdm-initialized", do_init);

setlistener("/sim/signals/reinit", func(n) {
	print("============ REINIT ATC-ML!");
    n.getBoolValue() and return;
    # HACK: something overwrites view & position if we call do_init from here
    settimer(do_init, 1);
});

setlistener("/sim/tower/airport-id", func {
   if(FDM_ON) { update_ICAO(getprop("/sim/tower/airport-id"))	};
});

setlistener("/sim/tower/altitude-ft", func {
    settimer(update_ALT, 0.5);
});

setlistener("/sim/multiplay/callsign", func {		## TBD: just bypassing UID-Switch
#	print("-------changed CALLSIGN found");
    if(FDM_ON){
		CMD_UID_sc.setBoolValue(0);	
		CMD_UID_sd.setBoolValue(1);
		fgcommand("dialog-update", props.Node.new({"dialog-name": "ATC-MPinRW"}));
		update_UID();
	}
});

#### sets data for any ICAO change: Initial & "/sim/tower/airport-id"-listener
var update_ICAO = func(ICAO)	{
	#print("-------ICAO changes from / to: ",getprop("/sim/presets/airport-id"), " / ",ICAO);
	#print("vor  :",getprop("/sim/tower/altitude-agl-ft"),", ",getprop("/sim/tower/altitude-ft"),", ",getprop("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-APalt"));
	if(FDM_ON){
		setprop("/sim/tower/airport-id", ICAO);
		setprop("/sim/presets/airport-id", ICAO);
		CMD_APname.setValue(airportinfo(getprop("/sim/tower/airport-id")).name);
		CMD_APalt.setValue(airportinfo(getprop("/sim/tower/airport-id")).elevation*3.281);
#	print("APalt: ",getprop("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-APalt"));
		setprop("/sim/tower/TWR-RWin-ICAO", getprop("/sim/tower/airport-id"));
		setprop("/position/latitude-deg", getprop("/sim/tower/latitude-deg"));
		setprop("/position/longitude-deg", getprop("/sim/tower/longitude-deg"));
		tower_coords.set_latlon(TWR_lat.getValue(), TWR_lon.getValue(), TWR_alt.getValue());
		Localizer_offset.setIntValue(0);
		Localizer_offset_display.setIntValue(0);
		Localizer_heading_deg.setIntValue(0);
#	print("nach :",getprop("/sim/tower/altitude-agl-ft"),", ",getprop("/sim/tower/altitude-ft"),", ",getprop("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-APalt"));
		update_UID()
}	}

#######################
var update_ALT = func()	{
		setprop("/sim/tower/altitude-agl-ft", getprop("/sim/tower/altitude-ft")-getprop("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-APalt"));
		setprop("/sim/tower/TWR-RWin-ALT", sprintf("%.f",getprop("/sim/tower/altitude-agl-ft")));
		setprop("/position/altitude-ft", sprintf("%.f",getprop("/sim/tower/altitude-ft")));  ### Why did I add that?? Brings wrong Gnd Indication!
		fgcommand("dialog-update", props.Node.new({"dialog-name": "ATC-MPinRW"}));
}


#######################
var update_UID = func() {
#	print("-------update_UID");
				#		if (cmp(CMD_UID_d.getValue()," ") == 0) { 
	CMD_UID_d.setValue(getprop("/sim/multiplay/callsign"));
				#	## TBD: just bypassing setting (a=1) for now }
	CMD_UID_a.setValue(getprop("/sim/tower/airport-id")~"-"~getprop("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-job")~"_"~getprop("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-UID_d"));
	CMD_UID_b.setValue(getprop("/sim/tower/airport-id")~"-"~getprop("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-job"));
	CMD_UID_c.setValue(getprop("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-UID_d")~"_"~getprop("/sim/tower/airport-id")~"-"~getprop("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-job"));

	if (CMD_UID_sa.getValue()==1) {
		CMD_UID.setValue(CMD_UID_a.getValue());
	} else {	
		if (CMD_UID_sb.getValue()==1) {
			CMD_UID.setValue(CMD_UID_b.getValue())
		} else {
			if (CMD_UID_sc.getValue()==1) {
				CMD_UID.setValue(CMD_UID_c.getValue())
			} else {
				if (CMD_UID_sd.getValue()==1) {
					CMD_UID.setValue(CMD_UID_d.getValue())
				} else {
					CMD_UID.setValue(CMD_UID_c.getValue());	## TBD: just bypassing setting (a=1) for now
					CMD_UID_sc.setBoolValue(1);							## TBD: just bypassing setting (a=1) for now
	}	}	}	}
}

##################################
var is_valid_target = func(target) {
	#print("-------check valid target: ",target.getNode("callsign").getValue());
	return target.getNode("valid").getValue() and (target.getNode("radar/range-nm").getValue()< getprop("/instrumentation/radar/reference-range-nm"));
}

# based on YASim function euler2orient - returned matrix should be transposed
var get_rotation_matrix = func(roll, pitch, yaw)  {
	#print("-------get_rotation_matrix");
    var out = [ 1, 0, 0, 0, 1, 0, 0, 0, 1 ];
    var col = 0;
    var x = 0;
    var y = 0;
    var z = 0;
    var s = math.sin(roll);
    var c = math.cos(roll);
    for(col = 0; col < 3; col += 1) {
        y = out[col + 3];
        z = out[col + 6];
        out[col + 3] = c * y - s * z;
        out[col + 6] = s * y + c * z;
    }
    s = math.sin(pitch);
    c = math.cos(pitch);
    for(col = 0; col < 3; col += 1) {
        x = out[col];
        z = out[col + 6];
        out[col]     = c * x + s * z;
        out[col + 6] = c * z - s * x;
    }
    s = math.sin(yaw);
    c = math.cos(yaw);
    for(col = 0; col< 3; col += 1) {
        x = out[col];
        y = out[col + 3];
        out[col]   = c * x - s * y;
        out[col+3] = s * x + c * y;
    }
    return out;
}

#################################
var tmul33 = func(matrix, vector) {
    var out = [ 0, 0, 0 ];
    for(var row = 0; row < 3; row += 1) {
        for(var col = 0; col < 3; col += 1) {
            out[row] += matrix[3 * col + row] * vector[col];
        }
    }
    return out;
}

#################
var tan = func(x) {
    return math.sin(x) / math.cos(x);
}

# adjust view so that it is centered at the given position 
# position 0 is center, position 1 is edge
var adjust_view = func(fov, position) {
   return ATC_panel_visibility.getValue() ? math.atan2(tan(fov * 0.00872665) * position, 1) * R2D : 0;
}

############################
var update_target = func(MP) {
    var alt = MP.getNode("position/altitude-ft").getValue();
    target_coords = geo.Coord.new();
    target_coords.set_latlon(
			MP.getNode("position/latitude-deg").getValue(),
			MP.getNode("position/longitude-deg").getValue(),
			alt * FT2M);
	ATC_target_range.setValue(target_coords.distance_to(tower_coords)*0.00053996);	# ++ covert meter to nm
    if (follow.getValue()) {
        var eye_coords = geo.Coord.new();

        # view offsets: 
        #   x right +
        #   y up +
        #   z back +

        eye_coords.set_latlon(TWR_lat.getValue(), TWR_lon.getValue(), TWR_alt.getValue() * FT2M);
        var matrix = get_rotation_matrix(ATC_roll.getValue() * D2R, ATC_pitch.getValue() * D2R, ATC_heading.getValue() * D2R);
        var offset = tmul33(matrix, [ ATC_offset_x.getValue(), -ATC_offset_z.getValue(), ATC_offset_y.getValue() ] );

        eye_coords.apply_course_distance(offset[1] < 0 ? 180 :  0, math.abs(offset[1]));
        eye_coords.apply_course_distance(offset[0] < 0 ? 270 : 90, math.abs(offset[0]));
        eye_coords.set_alt(eye_coords.alt() + offset[2]);
        var brg = -eye_coords.course_to(target_coords) + ATC_heading.getValue() + adjust_view(ATC_fov.getValue(), 0.586);

#Eric BU        var brg = -eye_coords.course_to(target_coords) + ATC_heading.getValue() - adjust_view(ATC_fov.getValue(), 0.586);
        var elevation = math.atan2(target_coords.alt() - eye_coords.alt(), eye_coords.distance_to(target_coords)) * R2D;
        # FIXME: assumes 4:3 aspect
        var pitch = elevation - ATC_pitch.getValue() * math.cos(brg * D2R) - ATC_roll.getValue() * math.sin(brg * D2R)
			- adjust_view(ATC_fov.getValue() * 0.75, 0.5);
        ATC_target_brg.setValue(brg);
        ATC_target_pitch.setValue(pitch);
    }
    ATC_target_alt.setValue(alt);
    ATC_target_id.setValue(MP.getNode("callsign").getValue());
    ATC_target_speed.setValue(MP.getNode("velocities/true-airspeed-kt").getValue());
    ATC_target_hdg.setValue(add_with_wrap(MP.getNode("orientation/true-heading-deg").getValue(),-(Mag_offset.getValue()),360));
} 

#########################
var adjust_alt = func(ht) {
    var twr=me.TWR_alt.getValue();
    twr=sprintf("%.f",twr+ht);
    me.TWR_alt.setValue(twr);
	#print("chg twr-altitude um/to: ",ht," / ",twr);
}

###################################
var get_target_chat_prefix = func() {
    tgt = me.ATC_target_id.getValue();
	if(tgt != "")
	   val = sprintf(" --> %s: ",tgt);
	else val = "";
	return val;
}

############################################
var add_with_wrap = func(value, step, limit) {
    value += step;
    if (value < 0) value += limit;
    if (value >= limit) value -= limit;
    
    return value;
}

############################
var step_target = func(step) {
	#print("---------- Step thru targets:");
    var mp_craft = props.globals.getNode("/ai/models").getChildren("multiplayer");
    var num = ATC_num.getValue();
    var ttl = size(mp_craft);
    if (ttl > 0) {
        num = add_with_wrap(num, step, ttl);
        if (step == 0) {
            # search upwards by default
            step = 1;
        }
        for(var tries = 0; tries < ttl; tries += 1) {
			if(mp_craft[num].getNode("callsign") != nil and mp_craft[num].getNode("valid").getValue()) {
                ATC_num.setValue(num);
                RADAR.getNode("selected-id", 1).setValue(mp_craft[num].getNode("id").getValue());
                return mp_craft[num];
			} else {
				#je 20110804: KILL INVALID TARGETS
				mp_craft[num].getNode("position/latitude-deg").setValue(0);
				mp_craft[num].getNode("position/longitude-deg").setValue(0);
			}
            num = add_with_wrap(num, step, ttl);
	}	}
    ATC_num.setValue(-1);
    RADAR.getNode("selected-id", 1).setValue(-1);
    return nil;
}

#########################
var update_systems = func {
	##set UTC/GMT time on Radar-Screen
	CMD_TimeS.setValue(getprop("/sim/time/utc/day-seconds")-getprop("/sim/time/warp"));
	CMD_TimeH.setValue(CMD_TimeS.getValue()/3600);
	CMD_TimeS.setValue(CMD_TimeS.getValue()-(CMD_TimeH.getValue()*3600));
	CMD_TimeM.setValue(CMD_TimeS.getValue()/60);
	CMD_Time.setValue(sprintf("real UTC: %s:%02d",getprop("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-TimeH"),getprop("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-TimeM")));

    if (FDM_ON) {
        Wind_displayed.setValue(add_with_wrap(Wind_reported.getValue(),-Mag_offset.getValue(),360)+0.5);
		target = step_target(0);
        if (target != nil) {	
			update_target(target);
#		} else {
#			ATC_target_alt.setValue("");
#			ATC_target_id.setValue("");
#			ATC_target_range.setValue(0);
#			ATC_target_speed.setValue(0);
#			ATC_target_hdg.setValue(0);
		}	
   		settimer(update_systems, 0);
	}
}

##################################
var select_font_callback = func(n) { 
    var font = n.getValue();
	var sFont = split("/",font);
    setprop("/instrumentation/radar/font/name", sFont[size(sFont)-1]);
	fgcommand("dialog-update", props.Node.new({"dialog-name": "ATC-MPinRW"}));
}

##########################
var select_atc_font = func {
    var font = getprop("/instrumentation/radar/font");
    var dir = getprop("/sim/fg-root") ~ "/Fonts";
    var file = "";
	#print("2 Sel font dir  file",font,", ",dir,", ",file);
    if (font != nil and size(font) > 0) {
        file = font;
        for(var i = size(font) - 2; i >= 0; i -= 1) {
            if (font[i] == `/`) {
                dir = substr(font, 0, i);
                file = substr(font, i + 1);
				print("4 Sel font dir  file",font[i],", ",dir,", ",file);
                break;
            }
        }
    }
    var selector = gui.FileSelector.new(select_font_callback, "Select ATC radar font", "Select", nil, dir, file);
    selector.open();
}

############################
var toggle_tracking = func() {
    follow.setValue(!follow.getValue());
}

#############################
var toggle_localizer = func() {
    Localizer_display.setValue(!Localizer_display.getValue());
}

################################
var step_radar_range = func(dir) {
    var range_node = RADAR.getNode("range");
    var range = range_node.getValue();
    range *= dir > 0 ? 2 : 0.5;
    if (range < 1) range = 1;
    if (range > 128) range = 128;			## je 100212 was 32
    range_node.setValue(range);
}

######################################
var step_localizer_heading = func(dir) {
   Localizer_heading_deg.setValue(add_with_wrap(Localizer_heading_deg.getValue(), dir, 360));
}


###################################################
### je 091213; ####################################
## switch MP on/off and read in the ATC-commands
var startMP = func {
#	print("-------startMP");
	if (MP_Status.getValue() == "on") {
		MP_Status.setValue("off");
		MP_Status_temp.setValue("off");
	} else {
		MP_Status.setValue("on");
		MP_Status_temp.setValue("on");
	}
	updateMP();
}

###### Load all Language defs		(at start of MP-featur and with each new Language def
var getLanguage = func	{
	#print("-------getLanguage");
	var ATCsh = io.open(ATCdir ~ "/ATCmsg/cmd-short.txt", "r");
	var ATCpr = io.open(ATCdir ~ "/ATCmsg/cmd-props.txt", "r");
	var ATCen = io.open(ATCdir ~ "/ATCmsg/en.txt", "r");
	CMD_lsum.setValue("en");
	if (CMD_L2.getValue() != "")	{
		CMD_L2.setValue(substr(CMD_L2.getValue(),0,2));
		ATCl2 = call(func io.open(ATCdir ~ "/ATCmsg/" ~ CMD_L2.getValue()~".txt", "r"), nil, var err=[]);
		if (size(err)) { CMD_L2.setValue("") }
		CMD_lsum.setValue(CMD_lsum.getValue()~" "~CMD_L2.getValue());
	}
	if (CMD_L3.getValue() != "")	{
		CMD_L3.setValue(substr(CMD_L3.getValue(),0,2));
		ATCl3 = call(func io.open(ATCdir ~ "/ATCmsg/"~CMD_L3.getValue()~".txt", "r"), nil, var err=[]);
		if (size(err)) { CMD_L3.setValue("") }
		CMD_lsum.setValue(CMD_lsum.getValue()~" "~CMD_L3.getValue());
	}
	var MPP = props.globals.getNode("/sim/gui/dialogs/ATC-ML/ATC-MP");
	var (line, line1) = ("00", "");
	for(var i = 0; line != nil; i += 1) {
		line = io.readln(ATCsh);
		if (line != nil) {
			MPP.getChild("command", i, 1);
			setprop("/sim/gui/dialogs/ATC-ML/ATC-MPCMDsel/dialog/list/value[" ~ i ~ "]", line);
			line1 = io.readln(ATCen);
			setprop("/sim/gui/dialogs/ATC-ML/ATC-MP/command[" ~ i ~ "]/en", line1);
			line1 = io.readln(ATCpr);
			if (line1 == nil) line1 = " "; 
			setprop("/sim/gui/dialogs/ATC-ML/ATC-MP/command[" ~ i ~ "]/properties", line1);
			if (CMD_L2.getValue() != "")	{
				line1 = io.readln(ATCl2);
				setprop("/sim/gui/dialogs/ATC-ML/ATC-MP/command[" ~ i ~ "]/"~CMD_L2.getValue(), line1);
			}
			if (CMD_L3.getValue() != "")	{
				line1 = io.readln(ATCl3);

				setprop("/sim/gui/dialogs/ATC-ML/ATC-MP/command[" ~ i ~ "]/"~CMD_L3.getValue(), line1);
	}	}	}
	io.close(ATCsh);
	io.close(ATCpr);
	io.close(ATCen);
	if (CMD_L2.getValue() != "")	io.close(ATCl2);
	if (CMD_L3.getValue() != "")	io.close(ATCl3);
}

###################
var updateMP = func {
	#print("-------updateMP");
	if (MP_Status.getValue() == "on") {
		var dlg = props.globals.getNode("/sim/gui/dialogs/ATC-ML/ATC-MP", 1);
		var list = dlg.getNode("dialog/list");
		list.removeChildren("value");
		ATCpropp = props.globals.getNode("/ai/models");
		var children = ATCpropp.getChildren("multiplayer");
	  	var mp_vec=[];
		foreach(var c; children) {
			if(c.getNode("callsign") != nil and c.getNode("valid").getValue()) {
			  append(mp_vec, { callsign:string.lc(c.getNode("callsign").getValue()), index:c.getIndex()});
			} else {
#				if (c.getNode("callsign") != ATC_target_id.getValue())	{
#				  ATC_target_alt.setValue("");
#				  ATC_target_id.setValue("");
#				  ATC_target_range.setValue(0);
#				  ATC_target_speed.setValue(0);
#				  ATC_target_hdg.setValue(0);
				  c.getNode("position/latitude-deg").setValue(0);
				  c.getNode("position/longitude-deg").setValue(0);
		}	}
		var player = 0;
		var sorted=sort(mp_vec, func(a,b) { return cmp(a.callsign,b.callsign) });
		foreach(var s; sorted) {
			var c = children[s.index];
			target_coords = geo.Coord.new();
			var TClat=c.getNode("position/latitude-deg").getValue();
			var TClon=c.getNode("position/longitude-deg").getValue();
			var TCvel=c.getNode("velocities/true-airspeed-kt").getValue();

			if (TClat<90 and TClat>-90 and TClon>-360 and TClon<360 and TCvel>0) {
				target_coords.set_latlon(c.getNode("position/latitude-deg").getValue(), c.getNode("position/longitude-deg").getValue(), c.getNode("velocities/true-airspeed-kt").getValue() * FT2M);
				Tnm = target_coords.distance_to(tower_coords)*0.00053996;	
			}
			else Tnm=0;
		    var ppS = c.getNode("sim/model/path");
		    if (ppS == nil) var ppOUT = " ";
			else	{
				var ppOUT = ppS.getValue();
			    var ppV = split("/", ppOUT);
				ppV = split(".",ppV[size(ppV)-1]);
				if (size(ppV) > 1) ppOUT =ppV[0];
				else ppOUT = " ";
			}
			var MP = sprintf("%-7.7s %5.2f %5.0f %4.0f  %3.0f  %-15.15s",
					c.getNode("callsign").getValue(),
					Tnm,
					c.getNode("position/altitude-ft").getValue(),
					c.getNode("velocities/true-airspeed-kt").getValue(),	
   				c.getNode("orientation/true-heading-deg").getValue(),
					ppOUT);
			list.getChild("value", player, 1).setValue(MP);
			player +=1;
		}
		fgcommand("dialog-close", props.Node.new({"object-name": "mplist", "dialog-name": "ATC-MP"}));
		fgcommand("dialog-show", props.Node.new({"object-name": "mplist", "dialog-name": "ATC-MP"}));
		settimer(updateMP, 3);	
	} else {
		settimer(updateMP, 1);			#0.5);
		fgcommand("dialog-close", props.Node.new({"object-name": "mplist", "dialog-name": "ATC-MP"}));
}	}

##############################
var search_new_target = func() {
	var mp_craft = props.globals.getNode("/ai/models").getChildren("multiplayer");
	var ttl = size(mp_craft);
	for(var CMD_NR = 0; CMD_NR < ttl; CMD_NR += 1) {
		if (getprop("/ai/models/multiplayer[" ~CMD_NR ~ "]/callsign") == getprop("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-target")) {
			RADAR.getNode("selected-id", 1).setValue(mp_craft[num].getNode("id").getValue());
}	}	}


#### ==========================================================================================================
####### Output to MP for ALL languages

#### Initiated from PopUp-List-Selection (ATC-MPCMDsel.xml)
var search_command = func() {
	#print("-------search_command");
	####################################################################################################
	#### WATCH: CMD-target  is a String-Value that is analysed here - in case you chage the List-String in ATC-MP you might have to change values here too!!
	if (size(CMD_target.getValue())>12)	{
		for (var i=7; i<16; i=i+1)	{
			if (substr(CMD_target.getValue(),i,1) != " ") break; 
		}
		setprop("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-target-range",num(substr(CMD_target.getValue(),i,13-i)));
		setprop("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-target",sprintf("%7.7s",CMD_target.getValue()));
	}			
	####################################################################################################
	MP_Status_temp.setValue(MP_Status.getValue());
	MP_Status.setValue("off");				# Mp and MPCMD may overlap - thus switch of MO while CMD showing
	fgcommand("dialog-show", props.Node.new({"dialog-name": "ATC-MPCMDsel"}));
}

############################
var search_command1 = func() {
	#print("-------search_command1");
	var ATCpropp = props.globals.getNode("/sim/gui/dialogs/ATC-ML/ATC-MPCMDsel/dialog/list").getChildren("value");
	var aaa = size(ATCpropp);
	for (var i = 0; i < aaa; i +=1) {
		var aab = getprop("/sim/gui/dialogs/ATC-ML/ATC-MPCMDsel/dialog/list/value[" ~ i ~ "]");
		if (aab == CMD_short.getValue())	{
			CMD_NR = i;
			def_output(CMD_NR);
}	}	}

#### Initiated from Radar-Settings
var def_cmd_target = func(dum) {
	#print("-------def_cmd_target");
	CMD_add.setValue("");
	CMD_NR = dum;
	CMD_target.setValue(ATC_target_id.getValue());
	CMD_target_range.setValue(ATC_target_range.getValue());
	MP_Status_temp.setValue(MP_Status.getValue());
	MP_Status.setValue("off");				# Mp and MPCMD may overlap - thus switch of MO while CMD showing
	def_output(CMD_NR);
}

### define the output-parts, selected by List/MouseClick (MPCMDsel.xml) or Radar-Base (atc-instr.xml)
var def_output = func(CMD_NR) {
	#print("-------def_output");
	CMD_add.setValue("");
	CMD_long.setValue(getprop("sim/gui/dialogs/ATC-ML/ATC-MP/command[" ~ CMD_NR ~ "]/en"));
	Pout = split(",", getprop("sim/gui/dialogs/ATC-ML/ATC-MP/command[" ~ CMD_NR ~ "]/properties"));	
	PoutS = size(Pout);						
	Sel_String(PoutS,CMD_NR);																											##### Compose the command
	fgcommand("dialog-show", props.Node.new({"dialog-name": "ATC-MPinMsg"}));			#### Input-Window to something to CMD + Output Original English
}

##### Output the Commands:
## Outut Basic (English)
var CMD_send_seq = func()	{													###### kicked off by Command verification ATC_MPinMsg.xml
	#print("-------CMD_send_seq");
	CMD_send();
	settimer(CMD_send_2,4,1);
}

## Output Language 2
var CMD_send_2 = func()	{
	if (CMD_NR > 1)	{
		if (CMD_L2.getValue() != "")	{
			CMD_long.setValue(getprop("sim/gui/dialogs/ATC-ML/ATC-MP/command[" ~ CMD_NR ~ "]/"~CMD_L2.getValue()));
			if (size(CMD_long.getValue()) > 0) {
				Sel_String(PoutS,CMD_NR);
				CMD_send();
		}	}
		settimer(CMD_send_3,4,1);
}	}

## Output Language 3
var CMD_send_3 = func()	{
	if (CMD_L3.getValue() != "")	{
		CMD_long.setValue(getprop("sim/gui/dialogs/ATC-ML/ATC-MP/command[" ~ CMD_NR ~ "]/"~CMD_L3.getValue()));
		if (size(CMD_long.getValue()) > 0) {
			Sel_String(PoutS,CMD_NR);
			CMD_send();
}	}	}

######################
var CMD_send = func () 	{
    var lchat = getprop("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-compose");
    var lchat1 = getprop("/sim/gui/dialogs/ATC-ML/ATC-MP/CMD-add");
	if (lchat1 != nil) lchat = lchat~" "~lchat1~"\n"; 
    if (lchat != "")	{
		chat_node.setValue(lchat);
#		setprop("/sim/multiplay/chat", lchat~"\n");
#		setprop("/sim/multiplay/chat-compose", "");
#		gui.dialog_update("chat", "compose"~"\n");
}	}

## Select Print-Command 
var Sel_String = func (PoutS, CMD_NR)	{
	#print("-------sel_Print-Command");
	if (CMD_NR==0) { Print_Pout0(); }
	if (Pout[0]==nil) { Print_Pout1(); }
	if (PoutS==1) { Print_Pout1(); }
	if (PoutS==2) { Print_Pout2(); }
	if (PoutS==3) { Print_Pout3(); }
	if (PoutS==4) { Print_Pout4(); }
	if (PoutS==5) { Print_Pout5(); }
	if (PoutS==6) { Print_Pout6(); }
	if (PoutS==7) { Print_Pout7(); }
	if (PoutS==8) { Print_Pout8(); }
	if (PoutS==9) { Print_Pout9(); }
}

var Print_Pout0 = func () {	CMD_compose.setValue(CMD_UID.getValue()~"-->"~CMD_long.getValue()); }
var Print_Pout1 = func () {	CMD_compose.setValue(CMD_UID.getValue()~"-->"~sprintf(CMD_long.getValue(),getprop(Pout[0]))); }
var Print_Pout2 = func () {	CMD_compose.setValue(CMD_UID.getValue()~"-->"~sprintf(CMD_long.getValue(),getprop(Pout[0]),getprop(Pout[1]))); }
var Print_Pout3 = func () {	CMD_compose.setValue(CMD_UID.getValue()~"-->"~sprintf(CMD_long.getValue(),getprop(Pout[0]),getprop(Pout[1]),getprop(Pout[2]))); }
var Print_Pout4 = func () {	CMD_compose.setValue(CMD_UID.getValue()~"-->"~sprintf(CMD_long.getValue(),getprop(Pout[0]),getprop(Pout[1]),getprop(Pout[2]),getprop(Pout[3]))); }
var Print_Pout5 = func () {	CMD_compose.setValue(CMD_UID.getValue()~"-->"~sprintf(CMD_long.getValue(),getprop(Pout[0]),getprop(Pout[1]),getprop(Pout[2]),getprop(Pout[3]),getprop(Pout[4]))); }
var Print_Pout6 = func () {	CMD_compose.setValue(CMD_UID.getValue()~"-->"~sprintf(CMD_long.getValue(),getprop(Pout[0]),getprop(Pout[1]),getprop(Pout[2]),getprop(Pout[3]),getprop(Pout[4]),getprop(Pout[5]))); }
var Print_Pout7 = func () {	CMD_compose.setValue(CMD_UID.getValue()~"-->"~sprintf(CMD_long.getValue(),getprop(Pout[0]),getprop(Pout[1]),getprop(Pout[2]),getprop(Pout[3]),getprop(Pout[4]),getprop(Pout[5]),getprop(Pout[6]))); }
var Print_Pout8 = func () {	CMD_compose.setValue(CMD_UID.getValue()~"-->"~sprintf(CMD_long.getValue(),getprop(Pout[0]),getprop(Pout[1]),getprop(Pout[2]),getprop(Pout[3]),getprop(Pout[4]),getprop(Pout[5]),getprop(Pout[6]),getprop(Pout[7]))); }
var Print_Pout9 = func () {	CMD_compose.setValue(CMD_UID.getValue()~"-->"~sprintf(CMD_long.getValue(),getprop(Pout[0]),getprop(Pout[1]),getprop(Pout[2]),getprop(Pout[3]),getprop(Pout[4]),getprop(Pout[5]),getprop(Pout[6]),getprop(Pout[7]),getprop(Pout[8]))); }


###################################################################################
###### Save/Load RADAR Settings		(Initiated by MPinRW.xml Load/Save/Delete) ######
###################################################################################

####### Read the Data from "RadarDat" file into properties/list 
var getRadarSettings = func	{
	#print(">>>> Read Data from RadarDat");
	RADfile = call(func io.open(RadarDat, "r"), nil, var err=[]);
	if (size(err))	{
		print("### ",RadarDat," not found	--> create deafault:");
		setprop("/sim/gui/dialogs/ATC-ML/ATC-MPinRW/DELETE","no");
		defineDataToSave()
	} else {
	props.globals.getNode("/sim/gui/dialogs/ATC-ML/ATC-MPinRW/dialog/group/group[1]/list").removeChildren("value");		
	var (line, line1) = ("00", "");
		for(var i = 0; line != nil; i += 1) {
			line = io.readln(RADfile);
			if (line != nil) {
				setprop("/sim/gui/dialogs/ATC-ML/ATC-MPinRW/dialog/group/group[1]/list/value[" ~ i ~ "]", line);			
		}	}
	io.close(RADfile);	
}	}

###### Load Radar-GUI with actual RadarData from Properties
var loadRadarSettings = func {		
	#print("-------LoadRadarSettings");
	SETTY = split("|",getprop("/sim/gui/dialogs/ATC-ML/ATC-MPinRW/setRadarSettings"));
	setprop("/sim/tower/airport-id",SETTY[0]);
	setprop("/sim/presets/airport-id",SETTY[0]);
	setprop("/sim/atc/activeRW",SETTY[1]);
	setprop("/sim/atc/localizer-heading-deg",SETTY[2]);
	setprop("/sim/atc/localizer-offset-display",SETTY[3]);
	setprop("/sim/atc/localizer-offset",SETTY[3]);
	setprop("/instrumentation/comm[0]/frequencies/selected-mhz",SETTY[4]);
	setprop("/instrumentation/comm[1]/frequencies/selected-mhz",SETTY[5]);
	setprop("/sim/tower/altitude-ft",SETTY[6]);
}

###### Define the Data to be saved to "RadarDat"
var defineDataToSave = func {
	### GET all already saved settings, add curent (SETTY), sort, save
	#print(">>>>>>>>>>>>>>>>Export RadarData");

	## get/renew already saved data from "RadarDat"
#	getRadarSettings();
 
	## read current settings to SETTY
	if (getprop("/sim/tower/airport-id") == "") { setprop("/sim/tower/airport-id","----") };
	if (getprop("/sim/atc/activeRW") == "") { setprop("/sim/atc/activeRW","0") };
	SETTY = sprintf("%s|%s|%3.0f|%3.0f|%5.3f|%5.3f|%s|/n",
		getprop("/sim/tower/airport-id"),
		getprop("/sim/atc/activeRW"),
		getprop("/sim/atc/localizer-heading-deg"),
		getprop("/sim/atc/localizer-offset"),
		getprop("/instrumentation/comm[0]/frequencies/selected-mhz"),
		getprop("/instrumentation/comm[1]/frequencies/selected-mhz"),
		getprop("/sim/tower/altitude-ft"));
	##print("generated SETTY = ",SETTY);

	if (getprop("/sim/gui/dialogs/ATC-ML/ATC-MPinRW/DELETE")=="no")	{
		### merge SETTY into data --> if
		var RADL = RADD.getNode("dialog/group/group[1]/list");
		RADC = RADL.getChildren("value")	;
		AZ = size(RADC);
		#print("AZ0: ",AZ);
		if (AZ > 0) {
			for(var i=0; i < AZ; i = i+1) {
			#print("AZ1: ",AZ);
				if (substr(SETTY,0,8) == substr(RADC[i].getValue(),0,8))	{
					if (SETTY != RADC[i].getValue())	{							# ask user if existing should be changed --> ATC-MPinRWcmp
						var maxi=0;
						var SS = split("|",SETTY);										# stop read values in case table size changed !
						maxi = size(SS);
						for(var j=0; j < maxi; j=j+1)	{
							setprop("/sim/gui/dialogs/ATC-ML/ATC-MPinRWcmp/dialog/group/text["~sprintf("%s",(3+(j*3)))~"]/label", SS[j]);
						}
						var RR = split("|",RADC[i].getValue());
						maxi = size(RR);
						for(var j=0; j < maxi; j=j+1)	{
							setprop("/sim/gui/dialogs/ATC-ML/ATC-MPinRWcmp/dialog/group/text["~sprintf("%s",(4+(j*3)))~"]/label", RR[j]);
						}
						fgcommand("dialog-open", props.Node.new({"dialog-name": "ATC-MPinRWcmp"}));
						fgcommand("dialog-show", props.Node.new({"dialog-name": "ATC-MPinRWcmp"}));
						AZ= -2 ;																					## ATC-MPinRWcmp decides save or not!
						## print("-----> found same code different contens - ask what todo");
					}		## not equal contense - continue
				}		## not equal ID - continue
			}		##Loop END
		}		## no chlidren yet - just add
	}
	if (AZ > -2) { saveRadarSettings() }
} 

###### write to "RadarDat"
var saveRadarSettings = func {
	#print(">>>>>>>>>>>>>>>>> SAVE RadarSettings");

	## insert SETTY if not done already
	##print("SETTY before insert/delet: ",SETTY);
	if (getprop("/sim/gui/dialogs/ATC-ML/ATC-MPinRW/DELETE")=="no")	{
		#by pass if DELETE

		# first test if it is Replacement (SETTY not set "" by COMP-GUI!)
		if (SETTY != "") {
			var RADL = RADD.getNode("dialog/group/group[1]/list");
			RADC = RADL.getChildren("value")	;
			A = size(RADC);
			for(var i=0; i<A; i=i+1)	{
				if (substr(SETTY,0,8) == substr(RADC[i].getValue(),0,8))	{
					RADC[i].setValue(SETTY);
	 				i=A+1;
					SETTY="";
				}
			}
			# if SETTY still !="" add to end
			if (SETTY != "") {
				A = size(RADC);
				setprop("/sim/gui/dialogs/ATC-ML/ATC-MPinRW/dialog/group/group[1]/list/value[" ~ A ~ "]", SETTY);
	}	}	}

	## sort Data
	#print("Sort Data");
	var RADL = RADD.getNode("dialog/group/group[1]/list");
	RADC = RADL.getChildren("value")	;
	var RADV = []	;
	foreach(var c; RADC) {
		append(RADV, { value:string.lc(c.getValue()), index:c.getIndex()} );
	}
	var sorted = sort(RADV, func(a,b) { return cmp(a.value, b.value) } );

	## export sorted Data to "RadarDat"
	#print("Write new ",RadarDat);
	RADfile = io.open(RadarDat, "w");
	var line = " ";
	if (getprop("/sim/gui/dialogs/ATC-ML/ATC-MPinRW/DELETE")=="yes")	{
		foreach(var s; sorted) {
			line = RADC[s.index].getValue();
			#print("Setty -- RADC: ",substr(SETTY,0,8)," -- ",substr(line,0,8));
			if (substr(SETTY,0,8) != substr(line,0,8))	{
				io.write(RADfile,line~"\n");
			} else {
				print("RADFILE NOT SAVED");
		}	}
	} else {
		foreach(var s; sorted) {
			line = RADC[s.index].getValue();
				io.write(RADfile,line~"\n");
		}	
	}		
	io.close(RADfile);
}

###################################################################################
###### Save/Load FONT Settings		(Initiated by MPinRW.xml button "Save Font") ######
###################################################################################

####### Read the Data from "FontDat" file into properties/list 
var getFontSettings = func	{
	#print(">>>> Read Data from FontDat");
	FOfile = call(func io.open(FontDat, "r"), nil, var err=[]);
	if (size(err))	{
		print("### ",FontDat," not found	--> create default:");
		#  Define default RADAR-Font
			setprop("/instrumentation/radar/font/name", "arial_black.txf");
			setprop("/instrumentation/radar/font/size", 8);
			setprop("/instrumentation/radar/font/line-spacing", 0);
		saveFontSettings();
		print("### Default FontDat ",FontDat," created");
	} else {
		var (line, line1) = ("00", "");
		line = io.readln(FOfile);
		if (line != nil) {
		# setprop("/instrumentation/radar/display-controls/RADAR-font", line);	
			var sFont = split("|",line);
			setprop("/instrumentation/radar/font/name",sFont[0]);
			setprop("/instrumentation/radar/font/size",sFont[1]);
			setprop("/instrumentation/radar/font/line-spacing",sFont[2]);
			io.close(FOfile);	
	}	}	
}

###### write to "FontDat"
var saveFontSettings = func	{
	FOfile = io.open(FontDat, "w");
	var line = sprintf("%s|%s|%s",getprop("/instrumentation/radar/font/name"),
		getprop("/instrumentation/radar/font/size"),
		getprop("/instrumentation/radar/font/line-spacing"));
	io.write(FOfile,line~"\n");
	io.close(FOfile);
}
####################################################################################################
