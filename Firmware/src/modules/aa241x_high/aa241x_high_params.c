/****************************************************************************
 *
 *   Copyright (c) 2013, 2014 PX4 Development Team. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in
 *    the documentation and/or other materials provided with the
 *    distribution.
 * 3. Neither the name PX4 nor the names of its contributors may be
 *    used to endorse or promote products derived from this software
 *    without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 * COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
 * OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
 * AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
 * ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 *
 ****************************************************************************/

/*
 * @file aa241x_fw_control_params.c
 *
 * Definition of custom parameters for fixedwing controllers
 * being written for AA241x.
 *
 *  @author Adrien Perkins		<adrienp@stanford.edu>
 */

#include "aa241x_high_params.h"



/*
 *  controller parameters, use max. 15 characters for param name!
 *
 */

/**
 * This is an example parameter.  The name of the parameter in QGroundControl
 * will be AAH_EXAMPLE and will be in the AAH dropdown.  Make sure to always
 * start your parameters with AAH to have them all in one place.
 *
 * The default value of this float parameter will be 10.0.
 *
 * @unit meter 						(the unit attribute (not required, just helps for sanity))
 * @group AA241x High Params		(always include this)
 */

/**
 * This is an example parameter.  The name of the parameter in QGroundControl
 * will be AAH_PROPROLLGAIN and will be in the AAH dropdown.  Make sure to always
 * start your parameters with AAH to have them all in one place.
 *
 * The default value of this float parameter will be 1.0.
 *
 * @unit none 						(the unit attribute (not required, just helps for sanity))
 * @group AA241x High Params		(always include this)
 */

// TODO: define custom parameters here

// Yaw gains
PARAM_DEFINE_FLOAT(AAH_P_YAWGAIN, 1.0f);
PARAM_DEFINE_FLOAT(AAH_I_YAWGAIN, 1.0f);
PARAM_DEFINE_FLOAT(AAH_D_RAWGAIN, 1.0f);


// Roll gains
PARAM_DEFINE_FLOAT(AAH_P_ROLLGAIN, 1.0f);
PARAM_DEFINE_FLOAT(AAH_I_ROLLGAIN, 1.0f);
PARAM_DEFINE_FLOAT(AAH_D_ROLLGAIN, 1.0f);

// Pith gains
PARAM_DEFINE_FLOAT(AAH_P_PITCHGAIN, 1.0f);
PARAM_DEFINE_FLOAT(AAH_I_PITCHGAIN, 1.0f);
PARAM_DEFINE_FLOAT(AAH_D_PITCHGAIN, 1.0f);

// Altitude gains
PARAM_DEFINE_FLOAT(AAH_P_ALTGAIN, 1.0f);
PARAM_DEFINE_FLOAT(AAH_I_ALTGAIN, 1.0f);
PARAM_DEFINE_FLOAT(AAH_D_ALTGAIN, 1.0f);

// Theta gains
PARAM_DEFINE_FLOAT(AAH_P_THGAIN, 1.0f);
PARAM_DEFINE_FLOAT(AAH_I_THGAIN, 1.0f);
PARAM_DEFINE_FLOAT(AAH_D_THGAIN, 1.0f);

int aah_parameters_init(struct aah_param_handles *h)
{

	/* for each of your custom parameters, make sure to define a corresponding
	 * variable in the aa_param_handles struct and the aa_params struct these
	 * structs can be found in the aa241x_fw_control_params.h file
	 *
	 * NOTE: the string passed to param_find is the same as the name provided
	 * in the above PARAM_DEFINE_FLOAT
	 */
	h-> proportional_yaw_gain 	= param_find("AAH_P_YAWGAIN");
	h-> integrator_yaw_gain 	= param_find("AAH_I_YAWGAIN");
	h-> derivative_yaw_gain 	= param_find("AAH_D_YAWGAIN")

	h-> proportional_roll_gain 	= param_find("AAH_P_ROLLAIN");
	h-> integrator_roll_gain 	= param_find("AAH_I_ROLLGAIN");
	h-> derivative_roll_gain 	= param_find("AAH_D_ROLLGAIN")	

	h-> proportional_yaw_gain 	= param_find("AAH_P_PITCHGAIN");
	h-> integrator_yaw_gain 	= param_find("AAH_I_PITCHGAIN");
	h-> derivative_yaw_gain 	= param_find("AAH_D_PITCHGAIN");

	h-> proportional_alt_gain 	= param_find("AAH_P_ALTAIN");
	h-> integrator_alt_gain 	= param_find("AAH_I_ALTGAIN");
	h-> derivative_alt_gain 	= param_find("AAH_D_ALTGAIN")	

	h-> proportional_yaw_gain 	= param_find("AAH_P_THGAIN");
	h-> integrator_yaw_gain 	= param_find("AAH_I_THGAIN");
	h-> derivative_yaw_gain 	= param_find("AAH_D_THGAIN");

	// TODO: add the above line for each of your custom parameters........

	return OK;
}

int aah_parameters_update(const struct aah_param_handles *h, struct aah_params *p)
{

	// for each of your custom parameters, make sure to add this line with
	// the corresponding variable name
	param_get(h->proportional_yaw_gain, &(p->proportional_yaw_gain));
	param_get(h->integrator_yaw_gain, &(p->integrator_yaw_gain));
	param_get(h->derivative_yaw_gain, &(p->derivative_yaw_gain));

	param_get(h->proportional_roll_gain, &(p->proportional_roll_gain));
	param_get(h->integrator_roll_gain, &(p->integrator_roll_gain));
	param_get(h->derivative_roll_gain, &(p->derivative_roll_gain));

	param_get(h->proportional_pitch_gain, &(p->proportional_pitch_gain));
	param_get(h->integrator_pitch_gain, &(p->integrator_pitch_gain));
	param_get(h->derivative_pitch_gain, &(p->derivative_pitch_gain));

	param_get(h->proportional_altitude_gain, &(p->proportional_altitude_gain));
	param_get(h->integrator_altitude_gain, &(p->integrator_altitude_gain));
	param_get(h->derivative_altitude_gain, &(p->derivative_altitude_gain));

	param_get(h->proportional_th_gain, &(p->proportional_th_gain));
	param_get(h->integrator_th_gain, &(p->integrator_th_gain));
	param_get(h->derivative_th_gain, &(p->derivative_th_gain));

	// TODO: add the above line for each of your custom parameters.....

	return OK;
}
