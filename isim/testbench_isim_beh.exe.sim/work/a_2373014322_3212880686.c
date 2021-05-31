/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Users/enkor/Downloads/UCiSW_projekt-led/led_controller.vhd";
extern char *IEEE_P_2592010699;

unsigned char ieee_p_2592010699_sub_1744673427_503743352(char *, char *, unsigned int , unsigned int );


static void work_a_2373014322_3212880686_p_0(char *t0)
{
    char *t1;
    unsigned char t2;
    char *t3;
    char *t4;
    unsigned char t5;
    unsigned char t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    int t13;

LAB0:    xsi_set_current_line(48, ng0);
    t1 = (t0 + 1312U);
    t2 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 3312);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(49, ng0);
    t3 = (t0 + 1512U);
    t4 = *((char **)t3);
    t5 = *((unsigned char *)t4);
    t6 = (t5 == (unsigned char)2);
    if (t6 != 0)
        goto LAB5;

LAB7:
LAB6:    xsi_set_current_line(54, ng0);
    t1 = (t0 + 1032U);
    t3 = *((char **)t1);
    t13 = *((int *)t3);
    if (t13 == 0)
        goto LAB9;

LAB14:    if (t13 == 1)
        goto LAB10;

LAB15:    if (t13 == 2)
        goto LAB11;

LAB16:    if (t13 == 3)
        goto LAB12;

LAB17:
LAB13:    xsi_set_current_line(65, ng0);
    t1 = (t0 + 5654);
    t4 = (t0 + 3392);
    t7 = (t4 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 2U);
    xsi_driver_first_trans_fast_port(t4);

LAB8:    xsi_set_current_line(68, ng0);
    t1 = (t0 + 1192U);
    t3 = *((char **)t1);
    t13 = *((int *)t3);
    if (t13 == 0)
        goto LAB20;

LAB25:    if (t13 == 1)
        goto LAB21;

LAB26:    if (t13 == 2)
        goto LAB22;

LAB27:    if (t13 == 3)
        goto LAB23;

LAB28:
LAB24:    xsi_set_current_line(79, ng0);
    t1 = (t0 + 5664);
    t4 = (t0 + 3456);
    t7 = (t4 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 2U);
    xsi_driver_first_trans_fast_port(t4);

LAB19:    goto LAB3;

LAB5:    xsi_set_current_line(50, ng0);
    t3 = (t0 + 5642);
    t8 = (t0 + 3392);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    memcpy(t12, t3, 2U);
    xsi_driver_first_trans_fast_port(t8);
    xsi_set_current_line(51, ng0);
    t1 = (t0 + 5644);
    t4 = (t0 + 3456);
    t7 = (t4 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 2U);
    xsi_driver_first_trans_fast_port(t4);
    goto LAB6;

LAB9:    xsi_set_current_line(56, ng0);
    t1 = (t0 + 5646);
    t7 = (t0 + 3392);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t11 = *((char **)t10);
    memcpy(t11, t1, 2U);
    xsi_driver_first_trans_fast_port(t7);
    goto LAB8;

LAB10:    xsi_set_current_line(58, ng0);
    t1 = (t0 + 5648);
    t4 = (t0 + 3392);
    t7 = (t4 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 2U);
    xsi_driver_first_trans_fast_port(t4);
    goto LAB8;

LAB11:    xsi_set_current_line(60, ng0);
    t1 = (t0 + 5650);
    t4 = (t0 + 3392);
    t7 = (t4 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 2U);
    xsi_driver_first_trans_fast_port(t4);
    goto LAB8;

LAB12:    xsi_set_current_line(62, ng0);
    t1 = (t0 + 5652);
    t4 = (t0 + 3392);
    t7 = (t4 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 2U);
    xsi_driver_first_trans_fast_port(t4);
    goto LAB8;

LAB18:;
LAB20:    xsi_set_current_line(70, ng0);
    t1 = (t0 + 5656);
    t7 = (t0 + 3456);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t11 = *((char **)t10);
    memcpy(t11, t1, 2U);
    xsi_driver_first_trans_fast_port(t7);
    goto LAB19;

LAB21:    xsi_set_current_line(72, ng0);
    t1 = (t0 + 5658);
    t4 = (t0 + 3456);
    t7 = (t4 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 2U);
    xsi_driver_first_trans_fast_port(t4);
    goto LAB19;

LAB22:    xsi_set_current_line(74, ng0);
    t1 = (t0 + 5660);
    t4 = (t0 + 3456);
    t7 = (t4 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 2U);
    xsi_driver_first_trans_fast_port(t4);
    goto LAB19;

LAB23:    xsi_set_current_line(76, ng0);
    t1 = (t0 + 5662);
    t4 = (t0 + 3456);
    t7 = (t4 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 2U);
    xsi_driver_first_trans_fast_port(t4);
    goto LAB19;

LAB29:;
}


extern void work_a_2373014322_3212880686_init()
{
	static char *pe[] = {(void *)work_a_2373014322_3212880686_p_0};
	xsi_register_didat("work_a_2373014322_3212880686", "isim/testbench_isim_beh.exe.sim/work/a_2373014322_3212880686.didat");
	xsi_register_executes(pe);
}
