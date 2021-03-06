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
 * @file aa241x_fw_control_params.h
 *
 * Definition of custom parameters for fixedwing controllers
 * being written for AA241x.
 *
 *  @author Adrien Perkins		<adrienp@stanford.edu>
 */
#pragma once

#ifndef AA241X_FW_CONTROL_PARAMS_H_
#define AA241X_FW_CONTROL_PARAMS_H_


#include <systemlib/param/param.h>

#ifdef __cplusplus
extern "C" {
#endif


/**
 * Struct of all of the custom parameters.
 *
 * Please make sure to add a variable for each of your newly defined
 * parameters here.
 */
struct aah_params {

        float proportional_yaw_gain;
        float integrator_yaw_gain;
        float derivative_yaw_gain;

        float proportional_roll_gain;
        float integrator_roll_gain;
        float derivative_roll_gain;

        float proportional_pitch_gain;
        float integrator_pitch_gain;
        float derivative_pitch_gain;

        float proportional_alt_gain;
        float integrator_alt_gain;
        float derivative_alt_gain;

        float proportional_th_gain;
        float integrator_th_gain;
        float derivative_th_gain;

	// TODO: add custom parameter variable names here......

};


/**
 * Struct of handles to all of the custom parameters.
 *
 *  Please make sure to add a variable for each of your newly
 *  defined parameters here.
 *
 *  NOTE: these variable names can be the same as the ones above
 *  (makes life easier if they are)
 */
struct aah_param_handles {

        param_t proportional_yaw_gain;
        param_t integrator_yaw_gain;
        param_t derivative_yaw_gain;

        param_t proportional_roll_gain;
        param_t integrator_roll_gain;
        param_t derivative_roll_gain;

        param_t proportional_pitch_gain;
        param_t integrator_pitch_gain;
        param_t derivative_pitch_gain;

        param_t proportional_alt_gain;
        param_t integrator_alt_gain;
        param_t derivative_alt_gain;

        param_t proportional_th_gain;
        param_t integrator_th_gain;
        param_t derivative_th_gain;

	// TODO: add custom parameter variable names here.......

};

/**
 * Initialize all parameter handles and values
 *
 */
int aah_parameters_init(struct aah_param_handles *h);

/**
 * Update all parameters
 *
 */

        proportional_yaw_gain = 1.0f;
        integrator_yaw_gain = 0.0f;
        derivative_yaw_gain = 0.0f;

        proportional_roll_gain = 1.0f;
        integrator_roll_gain = 0.0f;
        derivative_roll_gain = 0.0f;

        proportional_pitch_gain = 1.0f;
        integrator_pitch_gain = 0.0f;
        derivative_pitch_gain = 0.0f;

        proportional_alt_gain = 1.0f;
        integrator_alt_gain = 0.0f;
        derivative_alt_gain = 0.0f;

        proportional_th_gain = 1.0f;
        integrator_th_gain = 0.0f;
        derivative_th_gain = 0.0f;

        
int aah_parameters_update(const struct aah_param_handles *h, struct aah_params *p);

#ifdef __cplusplus
}
#endif




#endif /* AA241X_FW_CONTROL_PARAMS_H_ */
