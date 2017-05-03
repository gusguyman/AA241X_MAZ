/*
 * @file aa241x_fw_control.h
 *
 * Header file for PID control law.
 *
 *  @author Elise FOURNIER-BIDOZ		<efb@stanford.edu>
 *  @author YOUR NAME			<YOU@EMAIL.COM>
 */

#pragma once

#ifndef AA241X_HIGH_BASIC_CONTROL_LAW_H
#define AA241X_HIGH_BASIC_CONTROL_LAW_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <math.h>
#include <poll.h>
#include <time.h>
#include <drivers/drv_hrt.h>
#include <systemlib/err.h>
#include <geo/geo.h>
#include <systemlib/perf_counter.h>
#include <systemlib/systemlib.h>
#include <mathlib/mathlib.h>

void constant_yaw();
void constant_roll();
void constant_pitch();
void constant_altitude();
void constant_heading();
void constant_heading_altitude();


#endif // AA241X_HIGH_BASIC_CONTROL_LAW_H
