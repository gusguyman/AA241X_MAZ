/*
 * @file aa241x_fw_control.cpp
 *
 * Implementation of basic control laws (PID) for constant yaw, roll, pitch, and altitude.
 * Also includes constant heading and constant heading + altitude functions.
 *
 *  @author Elise FOURNIER-BIDOZ		<efb@stanford.edu>
 *  @author YOUR NAME			<YOU@EMAIL.COM>
 */

#include <uORB/uORB.h>

// include header file
#include "aa241x_high_control_law.h"
#include "aa241x_high_aux.h"

// needed for variable names
using namespace aa241x_high;

// define global variables (can be seen by all files in aa241x_high directory unless static keyword used)
float altitude_desired = 0.0f;
float altitude = 0.0f;

/**
 * Main function in which your code should be written.
 *
 * This is the only function that is executed at a set interval,
 * feel free to add all the function you'd like, but make sure all
 * the code you'd like executed on a loop is in this function.
 */

// // Make a PID yaw stabilizer // //

void constant_yaw() {

    yaw_desired = 0.0f; // yaw_desired already exists in aa241x_high_aux so no need to repeat float declaration

    Kp = aah_parameters.proportional_yaw_gain;
    Ki = aah_parameters.integrator_yaw_gain;
    Kd = aah_parameters.derivative_yaw_gain;
    integral = 0;
    err = 0;

    new_err = yaw_desired - yaw;
    integral  = integral + new_err;
    der  = new_err - err;
    err = new_err;

    dt = ;//execution time of loop.
    float PIDYawCorrection = Kp*err + (Ki*integral*dt) + (Kd*der/dt);

    // Do bounds checking to keep the yaw correction within the -1..1 limits of the servo output
    if (PIDYawCorrection > 1.0f) {
            PIDYawCorrection = 1.0f;
    } else if (PIDYawCorrection < -1.0f ) {
            PIDYawCorrection = -1.0f;
    }

    // ENSURE THAT YOU SET THE SERVO OUTPUTS!!!
    // outputs should be set to values between -1..1 (except throttle is 0..1)
    // where zero is no actuation, and -1,1 are full throw in either the + or - directions

    // Set output of roll servo to the control law output calculated above
    yaw_servo_out = PIDYawCorrection;
    // as an example, just passing through manual control to everything but roll
    pitch_servo_out = -man_pitch_in;
    roll_servo_out = man_roll_in;
    throttle_servo_out = man_throttle_in;
}

// // Make a PID roll stabilizer // //

void constant_roll() {

    roll_desired = 0.0f;

    Kp = aah_parameters.proportional_roll_gain;
    Ki = aah_parameters.integrator_roll_gain;
    Kd = aah_parameters.derivative_roll_gain;
    integral = 0;
    err = 0;

    new_err = roll_desired - roll;
    integral  = integral + new_err;
    der  = new_err - err;
    err = new_err;

    dt = ;
    float PIDRollCorrection = Kp*err + (Ki*integral*dt) + (Kd*der/dt);

    if (PIDRollCorrection > 1.0f) {
            PIDRollCorrection = 1.0f;
    } else if (PIDRollCorrection < -1.0f ) {
            PIDRollCorrection = -1.0f;
    }


    roll_servo_out = PIDRollCorrection;

    pitch_servo_out = -man_pitch_in;
    yaw_servo_out = man_yaw_in;
    throttle_servo_out = man_throttle_in;
}

// // Make a PID pitch stabilizer // //

void constant_pitch() {

    pitch_desired = 0.0f;

    Kp = aah_parameters.proportional_pitch_gain;
    Ki = aah_parameters.integrator_pitch_gain;
    Kd = aah_parameters.derivative_pitch_gain;
    integral = 0;
    err = 0;

    new_err = pitch_desired - pitch;
    integral  = integral + new_err;
    der  = new_err - err;
    err = new_err;

    dt = ;
    float PIDPitchCorrection = Kp*err + (Ki*integral*dt) + (Kd*der/dt);

    if (PIDPitchCorrection > 1.0f) {
            PIDPitchCorrection = 1.0f;
    } else if (PIDPitchCorrection < -1.0f ) {
            PIDPitchCorrection = -1.0f;
    }


    pitch_servo_out = PIDPitchCorrection;

    roll_servo_out = man_roll_in;
    yaw_servo_out = man_yaw_in;
    throttle_servo_out = man_throttle_in;
}

// // Make a PID altitude stabilizer // //

void constant_altitude() {

    altitude_desired = 0.0f;

    Kp = aah_parameters.proportional_altitude_gain;
    Ki = aah_parameters.integrator_altitude_gain;
    Kd = aah_parameters.derivative_altitude_gain;
    integral = 0;
    err = 0;

    new_err = altitude_desired - altitude;
    integral  = integral + new_err;
    der  = new_err - err;
    err = new_err;

    dt = ;
    float PIDAltitudeCorrection = Kp*err + (Ki*integral*dt) + (Kd*der/dt);

    if (PIDAltitudeCorrection > 1.0f) {
            PIDAltitudeCorrection = 1.0f;
    } else if (PIDAltitudeCorrection < -1.0f ) {
            PIDAltitudeCorrection = -1.0f;
    }

    //TO BE MODIFIED
    // /!\ h_dot = U0*(theta - alpha) so we need angle of attack alpha (= w/U0)
    //and vertical velocity h_dot to find pitch output /!\

    pitch_servo_out = -man_pitch_in;

    roll_servo_out = man_roll_in;
    yaw_servo_out = man_yaw_in;
    throttle_servo_out = man_throttle_in;
}

// // Make a heading stabilizer // //

void constant_heading() {
    constant_yaw();
    constant_roll();
}

// // Make an altitude + heading stabilizer // //

void constant_heading&altitude() {
    constant_heading();
    constant_altitude();
}


void flight_control() {

        //CALL THE FUNCTION WE WANT TO EXECUTE, OR DO SEVERAL IF STATEMENTS ACCORDING
        // TO WHAT FLIGHT MODE WE'RE IN

}
