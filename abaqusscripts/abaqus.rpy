# -*- coding: mbcs -*-
#
# Abaqus/CAE Release Unofficial Packaging Version replay file
# Internal Version: 2015_09_24-21.31.09 126547
# Run by quee3581 on Tue Dec 08 22:55:15 2020
#

# from driverUtils import executeOnCaeGraphicsStartup
# executeOnCaeGraphicsStartup()
#: Executing "onCaeGraphicsStartup()" in the site directory ...
from abaqus import *
from abaqusConstants import *
session.Viewport(name='Viewport: 1', origin=(1.32292, 1.32407), width=194.733, 
    height=131.348)
session.viewports['Viewport: 1'].makeCurrent()
from driverUtils import executeOnCaeStartup
executeOnCaeStartup()
execfile(
    'Z:/CM/GitHub/FatigueCMM/AnalysisofCantileverDimensions/newscripts/abaqusMacrostiffnessv2.py', 
    __main__.__dict__)
#: The model database "Z:\CM\ABAQUS\InUse\Foil3quadlfw\GeometryLoop\uhcfcantilever_30ir_for95_PARAMETRICOPT4-3stiff.cae" has been opened.
session.viewports['Viewport: 1'].setValues(displayedObject=None)
#: Run 0
#: length A = 1169.600
#: length B = 587.120
#: length C = 540.160
#: length D = 314.410
#: length E = 173.570
#: thickness= 44.994
#: Warning: Failed to attach mesh to part geometry.
#: Warning: Failed to attach mesh to part geometry.
#: 1169_587_540_314_173_44
#: Run 1
#: length A = 1174.600
#: length B = 590.290
#: length C = 537.550
#: length D = 319.400
#: length E = 178.060
#: thickness= 49.549
#: Warning: Failed to attach mesh to part geometry.
#: 1174_590_537_319_178_49
#: Run 2
#: length A = 1179.600
#: length B = 593.450
#: length C = 534.950
#: length D = 324.380
#: length E = 182.550
#: thickness= 54.103
#: Warning: Failed to attach mesh to part geometry.
#: 1179_593_534_324_182_54
#: Run 3
#: length A = 1184.500
#: length B = 596.610
#: length C = 532.350
#: length D = 329.370
#: length E = 187.040
#: thickness= 58.658
#: Warning: Failed to attach mesh to part geometry.
#: 1184_596_532_329_187_58
#: Run 4
#: length A = 1189.500
#: length B = 599.770
#: length C = 529.740
#: length D = 334.360
#: length E = 191.530
#: thickness= 63.212
#: Warning: Failed to attach mesh to part geometry.
#: 1189_599_529_334_191_63
#: Run 5
#: length A = 1168.200
#: length B = 588.000
#: length C = 538.620
#: length D = 311.290
#: length E = 172.070
#: thickness= 50.672
#: Warning: Failed to attach mesh to part geometry.
#: Warning: Failed to attach mesh to part geometry.
#: 1168_588_538_311_172_50
#: Run 6
#: length A = 1173.200
#: length B = 591.170
#: length C = 536.020
#: length D = 316.270
#: length E = 176.560
#: thickness= 55.227
#: Warning: Failed to attach mesh to part geometry.
#: 1173_591_536_316_176_55
#: Run 7
#: length A = 1178.100
#: length B = 594.330
#: length C = 533.410
#: length D = 321.260
#: length E = 181.050
#: thickness= 59.782
#: Warning: Failed to attach mesh to part geometry.
#: 1178_594_533_321_181_59
#: Run 8
#: length A = 1183.100
#: length B = 597.490
#: length C = 530.810
#: length D = 326.250
#: length E = 185.540
#: thickness= 64.336
#: Warning: Failed to attach mesh to part geometry.
#: 1183_597_530_326_185_64
#: Run 9
#: length A = 1188.100
#: length B = 600.650
#: length C = 528.210
#: length D = 331.240
#: length E = 190.030
#: thickness= 68.891
#: Warning: Failed to attach mesh to part geometry.
#: 1188_600_528_331_190_68
#: Run 10
#: length A = 1166.800
#: length B = 588.880
#: length C = 537.090
#: length D = 308.160
#: length E = 170.570
#: thickness= 56.351
#: Warning: Failed to attach mesh to part geometry.
#: Warning: Failed to attach mesh to part geometry.
#: 1166_588_537_308_170_56
#: Run 11
#: length A = 1171.700
#: length B = 592.050
#: length C = 534.480
#: length D = 313.150
#: length E = 175.060
#: thickness= 60.905
#: Warning: Failed to attach mesh to part geometry.
#: 1171_592_534_313_175_60
#: Run 12
#: length A = 1176.700
#: length B = 595.210
#: length C = 531.880
#: length D = 318.140
#: length E = 179.550
#: thickness= 65.460
#: Warning: Failed to attach mesh to part geometry.
#: 1176_595_531_318_179_65
#: Run 13
#: length A = 1181.700
#: length B = 598.370
#: length C = 529.280
#: length D = 323.130
#: length E = 184.040
#: thickness= 70.015
#: Warning: Failed to attach mesh to part geometry.
#: 1181_598_529_323_184_70
#: Run 14
#: length A = 1186.700
#: length B = 601.530
#: length C = 526.670
#: length D = 328.120
#: length E = 188.530
#: thickness= 74.569
#: Warning: Failed to attach mesh to part geometry.
#: 1186_601_526_328_188_74
#: Run 15
#: length A = 1165.400
#: length B = 589.760
#: length C = 535.550
#: length D = 305.040
#: length E = 169.060
#: thickness= 62.029
#: Warning: Failed to attach mesh to part geometry.
#: Warning: Failed to attach mesh to part geometry.
#: 1165_589_535_305_169_62
#: Run 16
#: length A = 1170.300
#: length B = 592.930
#: length C = 532.950
#: length D = 310.030
#: length E = 173.550
#: thickness= 66.584
#: Warning: Failed to attach mesh to part geometry.
#: 1170_592_532_310_173_66
#: Run 17
#: length A = 1175.300
#: length B = 596.090
#: length C = 530.350
#: length D = 315.020
#: length E = 178.040
#: thickness= 71.138
#: Warning: Failed to attach mesh to part geometry.
#: 1175_596_530_315_178_71
#: Run 18
#: length A = 1180.300
#: length B = 599.250
#: length C = 527.740
#: length D = 320.010
#: length E = 182.530
#: thickness= 75.693
#: Warning: Failed to attach mesh to part geometry.
#: 1180_599_527_320_182_75
#: Run 19
#: length A = 1185.200
#: length B = 602.410
#: length C = 525.140
#: length D = 324.990
#: length E = 187.020
#: thickness= 80.248
#: Warning: Failed to attach mesh to part geometry.
#: 1185_602_525_324_187_80
#: Run 20
#: length A = 1163.900
#: length B = 590.640
#: length C = 534.020
#: length D = 301.920
#: length E = 167.560
#: thickness= 67.708
#: Warning: Failed to attach mesh to part geometry.
#: Warning: Failed to attach mesh to part geometry.
#: 1163_590_534_301_167_67
#: Run 21
#: length A = 1168.900
#: length B = 593.810
#: length C = 531.420
#: length D = 306.910
#: length E = 172.050
#: thickness= 72.262
#: Warning: Failed to attach mesh to part geometry.
#: 1168_593_531_306_172_72
#: Run 22
#: length A = 1173.900
#: length B = 596.970
#: length C = 528.810
#: length D = 311.900
#: length E = 176.540
#: thickness= 76.817
#: Warning: Failed to attach mesh to part geometry.
#: 1173_596_528_311_176_76
#: Run 23
#: length A = 1178.900
#: length B = 600.130
#: length C = 526.210
#: length D = 316.890
#: length E = 181.030
#: thickness= 81.372
#: Warning: Failed to attach mesh to part geometry.
#: 1178_600_526_316_181_81
#: Run 24
#: length A = 1183.800
#: length B = 603.290
#: length C = 523.600
#: length D = 321.870
#: length E = 185.520
#: thickness= 85.926
#: Warning: Failed to attach mesh to part geometry.
#: 1183_603_523_321_185_85
#: Run 25
#: length A = 1169.500
#: length B = 586.140
#: length C = 541.700
#: length D = 316.340
#: length E = 173.660
#: thickness= 49.898
#: Warning: Failed to attach mesh to part geometry.
#: Warning: Failed to attach mesh to part geometry.
#: 1169_586_541_316_173_49
#: Run 26
#: length A = 1174.400
#: length B = 589.300
#: length C = 539.100
#: length D = 321.330
#: length E = 178.150
#: thickness= 54.453
#: Warning: Failed to attach mesh to part geometry.
#: 1174_589_539_321_178_54
#: Run 27
#: length A = 1179.400
#: length B = 592.460
#: length C = 536.490
#: length D = 326.320
#: length E = 182.640
#: thickness= 59.007
#: Warning: Failed to attach mesh to part geometry.
#: 1179_592_536_326_182_59
#: Run 28
#: length A = 1184.400
#: length B = 595.620
#: length C = 533.890
#: length D = 331.310
#: length E = 187.130
#: thickness= 63.562
#: Warning: Failed to attach mesh to part geometry.
#: 1184_595_533_331_187_63
#: Run 29
#: length A = 1189.400
#: length B = 598.780
#: length C = 531.290
#: length D = 336.290
#: length E = 191.620
#: thickness= 68.117
#: Warning: Failed to attach mesh to part geometry.
#: 1189_598_531_336_191_68
#: Run 30
#: length A = 1168.100
#: length B = 587.020
#: length C = 540.170
#: length D = 313.220
#: length E = 172.160
#: thickness= 55.576
#: Warning: Failed to attach mesh to part geometry.
#: Warning: Failed to attach mesh to part geometry.
#: 1168_587_540_313_172_55
#: Run 31
#: length A = 1173.000
#: length B = 590.180
#: length C = 537.560
#: length D = 318.210
#: length E = 176.650
#: thickness= 60.131
#: Warning: Failed to attach mesh to part geometry.
#: 1173_590_537_318_176_60
#: Run 32
#: length A = 1178.000
#: length B = 593.340
#: length C = 534.960
#: length D = 323.200
#: length E = 181.140
#: thickness= 64.686
#: Warning: Failed to attach mesh to part geometry.
#: 1178_593_534_323_181_64
#: Run 33
#: length A = 1183.000
#: length B = 596.500
#: length C = 532.360
#: length D = 328.180
#: length E = 185.630
#: thickness= 69.240
#: Warning: Failed to attach mesh to part geometry.
#: 1183_596_532_328_185_69
#: Run 34
#: length A = 1187.900
#: length B = 599.660
#: length C = 529.750
#: length D = 333.170
#: length E = 190.120
#: thickness= 73.795
#: Warning: Failed to attach mesh to part geometry.
#: 1187_599_529_333_190_73
#: Run 35
#: length A = 1166.600
#: length B = 587.900
#: length C = 538.630
#: length D = 310.100
#: length E = 170.660
#: thickness= 61.255
#: Warning: Failed to attach mesh to part geometry.
#: Warning: Failed to attach mesh to part geometry.
#: 1166_587_538_310_170_61
#: Run 36
#: length A = 1171.600
#: length B = 591.060
#: length C = 536.030
#: length D = 315.090
#: length E = 175.150
#: thickness= 65.809
#: Warning: Failed to attach mesh to part geometry.
#: 1171_591_536_315_175_65
#: Run 37
#: length A = 1176.600
#: length B = 594.220
#: length C = 533.430
#: length D = 320.070
#: length E = 179.640
#: thickness= 70.364
#: Warning: Failed to attach mesh to part geometry.
#: 1176_594_533_320_179_70
#: Run 38
#: length A = 1181.600
#: length B = 597.380
#: length C = 530.820
#: length D = 325.060
#: length E = 184.130
#: thickness= 74.919
#: Warning: Failed to attach mesh to part geometry.
#: 1181_597_530_325_184_74
#: Run 39
#: length A = 1186.500
#: length B = 600.540
#: length C = 528.220
#: length D = 330.050
#: length E = 188.620
#: thickness= 79.473
#: Warning: Failed to attach mesh to part geometry.
#: 1186_600_528_330_188_79
#: Run 40
#: length A = 1165.200
#: length B = 588.780
#: length C = 537.100
#: length D = 306.980
#: length E = 169.160
#: thickness= 66.933
#: Warning: Failed to attach mesh to part geometry.
#: Warning: Failed to attach mesh to part geometry.
#: 1165_588_537_306_169_66
#: Run 41
#: length A = 1170.200
#: length B = 591.940
#: length C = 534.500
#: length D = 311.970
#: length E = 173.650
#: thickness= 71.488
#: Warning: Failed to attach mesh to part geometry.
#: 1170_591_534_311_173_71
#: Run 42
#: length A = 1175.200
#: length B = 595.100
#: length C = 531.890
#: length D = 316.950
#: length E = 178.140
#: thickness= 76.043
#: Warning: Failed to attach mesh to part geometry.
#: 1175_595_531_316_178_76
#: Run 43
#: length A = 1180.100
#: length B = 598.260
#: length C = 529.290
#: length D = 321.940
#: length E = 182.630
#: thickness= 80.597
#: Warning: Failed to attach mesh to part geometry.
#: 1180_598_529_321_182_80
#: Run 44
#: length A = 1185.100
#: length B = 601.420
#: length C = 526.680
#: length D = 326.930
#: length E = 187.120
#: thickness= 85.152
#: Warning: Failed to attach mesh to part geometry.
#: 1185_601_526_326_187_85
#: Run 45
#: length A = 1163.800
#: length B = 589.660
#: length C = 535.560
#: length D = 303.860
#: length E = 167.660
#: thickness= 72.612
#: Warning: Failed to attach mesh to part geometry.
#: Warning: Failed to attach mesh to part geometry.
#: 1163_589_535_303_167_72
#: Run 46
#: length A = 1168.800
#: length B = 592.820
#: length C = 532.960
#: length D = 308.840
#: length E = 172.150
#: thickness= 77.166
#: Warning: Failed to attach mesh to part geometry.
#: 1168_592_532_308_172_77
#: Run 47
#: length A = 1173.800
#: length B = 595.980
#: length C = 530.360
#: length D = 313.830
#: length E = 176.640
#: thickness= 81.721
#: Warning: Failed to attach mesh to part geometry.
#: 1173_595_530_313_176_81
#: Run 48
#: length A = 1178.700
#: length B = 599.140
#: length C = 527.750
#: length D = 318.820
#: length E = 181.130
#: thickness= 86.276
#: Warning: Failed to attach mesh to part geometry.
#: 1178_599_527_318_181_86
#: Run 49
#: length A = 1183.700
#: length B = 602.300
#: length C = 525.150
#: length D = 323.810
#: length E = 185.620
#: thickness= 90.830
#: Warning: Failed to attach mesh to part geometry.
#: 1183_602_525_323_185_90
#: Run 50
#: length A = 1169.300
#: length B = 585.150
#: length C = 543.250
#: length D = 318.280
#: length E = 173.750
#: thickness= 54.802
#: Warning: Failed to attach mesh to part geometry.
#: Warning: Failed to attach mesh to part geometry.
#: 1169_585_543_318_173_54
#: Run 51
#: length A = 1174.300
#: length B = 588.310
#: length C = 540.640
#: length D = 323.260
#: length E = 178.240
#: thickness= 59.357
#: Warning: Failed to attach mesh to part geometry.
#: 1174_588_540_323_178_59
#: Run 52
#: length A = 1179.300
#: length B = 591.470
#: length C = 538.040
#: length D = 328.250
#: length E = 182.730
#: thickness= 63.911
#: Warning: Failed to attach mesh to part geometry.
#: 1179_591_538_328_182_63
#: Run 53
#: length A = 1184.300
#: length B = 594.630
#: length C = 535.440
#: length D = 333.240
#: length E = 187.220
#: thickness= 68.466
#: Warning: Failed to attach mesh to part geometry.
#: 1184_594_535_333_187_68
#: Run 54
#: length A = 1189.200
#: length B = 597.790
#: length C = 532.830
#: length D = 338.230
#: length E = 191.710
#: thickness= 73.021
#: Warning: Failed to attach mesh to part geometry.
#: 1189_597_532_338_191_73
#: Run 55
#: length A = 1167.900
#: length B = 586.030
#: length C = 541.710
#: length D = 315.150
#: length E = 172.250
#: thickness= 60.480
#: Warning: Failed to attach mesh to part geometry.
#: Warning: Failed to attach mesh to part geometry.
#: 1167_586_541_315_172_60
#: Run 56
#: length A = 1172.900
#: length B = 589.190
#: length C = 539.110
#: length D = 320.140
#: length E = 176.740
#: thickness= 65.035
#: Warning: Failed to attach mesh to part geometry.
#: 1172_589_539_320_176_65
#: Run 57
#: length A = 1177.900
#: length B = 592.350
#: length C = 536.510
#: length D = 325.130
#: length E = 181.230
#: thickness= 69.590
#: Warning: Failed to attach mesh to part geometry.
#: 1177_592_536_325_181_69
#: Run 58
#: length A = 1182.800
#: length B = 595.510
#: length C = 533.900
#: length D = 330.120
#: length E = 185.720
#: thickness= 74.144
#: Warning: Failed to attach mesh to part geometry.
#: 1182_595_533_330_185_74
#: Run 59
#: length A = 1187.800
#: length B = 598.680
#: length C = 531.300
#: length D = 335.110
#: length E = 190.210
#: thickness= 78.699
#: Warning: Failed to attach mesh to part geometry.
#: 1187_598_531_335_190_78
#: Run 60
#: length A = 1166.500
#: length B = 586.910
#: length C = 540.180
#: length D = 312.030
#: length E = 170.750
#: thickness= 66.159
#: Warning: Failed to attach mesh to part geometry.
#: Warning: Failed to attach mesh to part geometry.
#: 1166_586_540_312_170_66
#: Run 61
#: length A = 1171.500
#: length B = 590.070
#: length C = 537.580
#: length D = 317.020
#: length E = 175.240
#: thickness= 70.714
#: Warning: Failed to attach mesh to part geometry.
#: 1171_590_537_317_175_70
#: Run 62
#: length A = 1176.500
#: length B = 593.230
#: length C = 534.970
#: length D = 322.010
#: length E = 179.730
#: thickness= 75.268
#: Warning: Failed to attach mesh to part geometry.
#: 1176_593_534_322_179_75
#: Run 63
#: length A = 1181.400
#: length B = 596.390
#: length C = 532.370
#: length D = 327.000
#: length E = 184.220
#: thickness= 79.823
#: Warning: Failed to attach mesh to part geometry.
#: 1181_596_532_327_184_79
#: Run 64
#: length A = 1186.400
#: length B = 599.560
#: length C = 529.760
#: length D = 331.990
#: length E = 188.710
#: thickness= 84.378
#: Warning: Failed to attach mesh to part geometry.
#: 1186_599_529_331_188_84
#: Run 65
#: length A = 1165.100
#: length B = 587.790
#: length C = 538.640
#: length D = 308.910
#: length E = 169.250
#: thickness= 71.837
#: Warning: Failed to attach mesh to part geometry.
#: Warning: Failed to attach mesh to part geometry.
#: 1165_587_538_308_169_71
#: Run 66
#: length A = 1170.100
#: length B = 590.950
#: length C = 536.040
#: length D = 313.900
#: length E = 173.740
#: thickness= 76.392
#: Warning: Failed to attach mesh to part geometry.
#: 1170_590_536_313_173_76
#: Run 67
#: length A = 1175.000
#: length B = 594.110
#: length C = 533.440
#: length D = 318.890
#: length E = 178.230
#: thickness= 80.947
#: Warning: Failed to attach mesh to part geometry.
#: 1175_594_533_318_178_80
#: Run 68
#: length A = 1180.000
#: length B = 597.270
#: length C = 530.830
#: length D = 323.880
#: length E = 182.720
#: thickness= 85.501
#: Warning: Failed to attach mesh to part geometry.
#: 1180_597_530_323_182_85
#: Run 69
#: length A = 1185.000
#: length B = 600.440
#: length C = 528.230
#: length D = 328.860
#: length E = 187.210
#: thickness= 90.056
#: Warning: Failed to attach mesh to part geometry.
#: 1185_600_528_328_187_90
#: Run 70
#: length A = 1163.700
#: length B = 588.670
#: length C = 537.110
#: length D = 305.790
#: length E = 167.750
#: thickness= 77.516
#: Warning: Failed to attach mesh to part geometry.
#: Warning: Failed to attach mesh to part geometry.
#: 1163_588_537_305_167_77
#: Run 71
#: length A = 1168.700
#: length B = 591.830
#: length C = 534.510
#: length D = 310.780
#: length E = 172.240
#: thickness= 82.070
#: Warning: Failed to attach mesh to part geometry.
#: 1168_591_534_310_172_82
#: Run 72
#: length A = 1173.600
#: length B = 594.990
#: length C = 531.900
#: length D = 315.770
#: length E = 176.730
#: thickness= 86.625
#: Warning: Failed to attach mesh to part geometry.
#: 1173_594_531_315_176_86
#: Run 73
#: length A = 1178.600
#: length B = 598.150
#: length C = 529.300
#: length D = 320.750
#: length E = 181.220
#: thickness= 91.180
#: Warning: Failed to attach mesh to part geometry.
#: 1178_598_529_320_181_91
#: Run 74
#: length A = 1183.600
#: length B = 601.320
#: length C = 526.700
#: length D = 325.740
#: length E = 185.710
#: thickness= 95.734
#: Warning: Failed to attach mesh to part geometry.
#: 1183_601_526_325_185_95
#: Run 75
#: length A = 1169.200
#: length B = 584.160
#: length C = 544.790
#: length D = 320.210
#: length E = 173.850
#: thickness= 59.706
#: Warning: Failed to attach mesh to part geometry.
#: Warning: Failed to attach mesh to part geometry.
#: 1169_584_544_320_173_59
#: Run 76
#: length A = 1174.200
#: length B = 587.320
#: length C = 542.190
#: length D = 325.200
#: length E = 178.340
#: thickness= 64.261
#: Warning: Failed to attach mesh to part geometry.
#: 1174_587_542_325_178_64
#: Run 77
#: length A = 1179.200
#: length B = 590.490
#: length C = 539.590
#: length D = 330.190
#: length E = 182.830
#: thickness= 68.815
#: Warning: Failed to attach mesh to part geometry.
#: 1179_590_539_330_182_68
#: Run 78
#: length A = 1184.100
#: length B = 593.650
#: length C = 536.980
#: length D = 335.170
#: length E = 187.320
#: thickness= 73.370
#: Warning: Failed to attach mesh to part geometry.
#: 1184_593_536_335_187_73
#: Run 79
#: length A = 1189.100
#: length B = 596.810
#: length C = 534.380
#: length D = 340.160
#: length E = 191.810
#: thickness= 77.925
#: Warning: Failed to attach mesh to part geometry.
#: 1189_596_534_340_191_77
#: Run 80
#: length A = 1167.800
#: length B = 585.040
#: length C = 543.260
#: length D = 317.090
#: length E = 172.350
#: thickness= 65.385
#: Warning: Failed to attach mesh to part geometry.
#: Warning: Failed to attach mesh to part geometry.
#: 1167_585_543_317_172_65
#: Run 81
#: length A = 1172.800
#: length B = 588.200
#: length C = 540.660
#: length D = 322.080
#: length E = 176.840
#: thickness= 69.939
#: Warning: Failed to attach mesh to part geometry.
#: 1172_588_540_322_176_69
#: Run 82
#: length A = 1177.700
#: length B = 591.370
#: length C = 538.050
#: length D = 327.070
#: length E = 181.330
#: thickness= 74.494
#: Warning: Failed to attach mesh to part geometry.
#: 1177_591_538_327_181_74
#: Run 83
#: length A = 1182.700
#: length B = 594.530
#: length C = 535.450
#: length D = 332.050
#: length E = 185.820
#: thickness= 79.049
#: Warning: Failed to attach mesh to part geometry.
#: 1182_594_535_332_185_79
#: Run 84
#: length A = 1187.700
#: length B = 597.690
#: length C = 532.840
#: length D = 337.040
#: length E = 190.310
#: thickness= 83.603
#: Warning: Failed to attach mesh to part geometry.
#: 1187_597_532_337_190_83
#: Run 85
#: length A = 1166.400
#: length B = 585.920
#: length C = 541.720
#: length D = 313.970
#: length E = 170.840
#: thickness= 71.063
#: Warning: Failed to attach mesh to part geometry.
#: Warning: Failed to attach mesh to part geometry.
#: 1166_585_541_313_170_71
#: Run 86
#: length A = 1171.400
#: length B = 589.080
#: length C = 539.120
#: length D = 318.960
#: length E = 175.330
#: thickness= 75.618
#: Warning: Failed to attach mesh to part geometry.
#: 1171_589_539_318_175_75
#: Run 87
#: length A = 1176.300
#: length B = 592.250
#: length C = 536.520
#: length D = 323.940
#: length E = 179.820
#: thickness= 80.172
#: Warning: Failed to attach mesh to part geometry.
#: 1176_592_536_323_179_80
#: Run 88
#: length A = 1181.300
#: length B = 595.410
#: length C = 533.910
#: length D = 328.930
#: length E = 184.310
#: thickness= 84.727
#: Warning: Failed to attach mesh to part geometry.
#: 1181_595_533_328_184_84
#: Run 89
#: length A = 1186.300
#: length B = 598.570
#: length C = 531.310
#: length D = 333.920
#: length E = 188.800
#: thickness= 89.282
#: Warning: Failed to attach mesh to part geometry.
#: 1186_598_531_333_188_89
#: Run 90
#: length A = 1165.000
#: length B = 586.800
#: length C = 540.190
#: length D = 310.850
#: length E = 169.340
#: thickness= 76.741
#: Warning: Failed to attach mesh to part geometry.
#: Warning: Failed to attach mesh to part geometry.
#: 1165_586_540_310_169_76
#: Run 91
#: length A = 1169.900
#: length B = 589.960
#: length C = 537.590
#: length D = 315.830
#: length E = 173.830
#: thickness= 81.296
#: Warning: Failed to attach mesh to part geometry.
#: 1169_589_537_315_173_81
#: Run 92
#: length A = 1174.900
#: length B = 593.130
#: length C = 534.980
#: length D = 320.820
#: length E = 178.320
#: thickness= 85.851
#: Warning: Failed to attach mesh to part geometry.
#: 1174_593_534_320_178_85
#: Run 93
#: length A = 1179.900
#: length B = 596.290
#: length C = 532.380
#: length D = 325.810
#: length E = 182.810
#: thickness= 90.405
#: Warning: Failed to attach mesh to part geometry.
#: 1179_596_532_325_182_90
#: Run 94
#: length A = 1184.900
#: length B = 599.450
#: length C = 529.780
#: length D = 330.800
#: length E = 187.300
#: thickness= 94.960
#: Warning: Failed to attach mesh to part geometry.
#: 1184_599_529_330_187_94
#: Run 95
#: length A = 1163.500
#: length B = 587.680
#: length C = 538.660
#: length D = 307.720
#: length E = 167.840
#: thickness= 82.420
#: Warning: Failed to attach mesh to part geometry.
#: Warning: Failed to attach mesh to part geometry.
#: 1163_587_538_307_167_82
#: Run 96
#: length A = 1168.500
#: length B = 590.840
#: length C = 536.050
#: length D = 312.710
#: length E = 172.330
#: thickness= 86.975
#: Warning: Failed to attach mesh to part geometry.
#: 1168_590_536_312_172_86
#: Run 97
#: length A = 1173.500
#: length B = 594.010
#: length C = 533.450
#: length D = 317.700
#: length E = 176.820
#: thickness= 91.529
#: Warning: Failed to attach mesh to part geometry.
#: 1173_594_533_317_176_91
#: Run 98
#: length A = 1178.500
#: length B = 597.170
#: length C = 530.840
#: length D = 322.690
#: length E = 181.310
#: thickness= 96.084
#: Warning: Failed to attach mesh to part geometry.
#: 1178_597_530_322_181_96
#: Run 99
#: length A = 1183.400
#: length B = 600.330
#: length C = 528.240
#: length D = 327.680
#: length E = 185.800
#: thickness= 100.640
#: Warning: Failed to attach mesh to part geometry.
#: 1183_600_528_327_185_100
#: Run 100
#: length A = 1169.100
#: length B = 583.180
#: length C = 546.340
#: length D = 322.150
#: length E = 173.940
#: thickness= 64.610
#: Warning: Failed to attach mesh to part geometry.
#: Warning: Failed to attach mesh to part geometry.
#: 1169_583_546_322_173_64
#: Run 101
#: length A = 1174.100
#: length B = 586.340
#: length C = 543.740
#: length D = 327.130
#: length E = 178.430
#: thickness= 69.165
#: Warning: Failed to attach mesh to part geometry.
#: 1174_586_543_327_178_69
#: Run 102
#: length A = 1179.000
#: length B = 589.500
#: length C = 541.130
#: length D = 332.120
#: length E = 182.920
#: thickness= 73.720
#: Warning: Failed to attach mesh to part geometry.
#: 1179_589_541_332_182_73
#: Run 103
#: length A = 1184.000
#: length B = 592.660
#: length C = 538.530
#: length D = 337.110
#: length E = 187.410
#: thickness= 78.274
#: Warning: Failed to attach mesh to part geometry.
#: 1184_592_538_337_187_78
#: Run 104
#: length A = 1189.000
#: length B = 595.820
#: length C = 535.920
#: length D = 342.100
#: length E = 191.900
#: thickness= 82.829
#: Warning: Failed to attach mesh to part geometry.
#: 1189_595_535_342_191_82
#: Run 105
#: length A = 1167.700
#: length B = 584.060
#: length C = 544.800
#: length D = 319.020
#: length E = 172.440
#: thickness= 70.289
#: Warning: Failed to attach mesh to part geometry.
#: Warning: Failed to attach mesh to part geometry.
#: 1167_584_544_319_172_70
#: Run 106
#: length A = 1172.600
#: length B = 587.220
#: length C = 542.200
#: length D = 324.010
#: length E = 176.930
#: thickness= 74.843
#: Warning: Failed to attach mesh to part geometry.
#: 1172_587_542_324_176_74
#: Run 107
#: length A = 1177.600
#: length B = 590.380
#: length C = 539.600
#: length D = 329.000
#: length E = 181.420
#: thickness= 79.398
#: Warning: Failed to attach mesh to part geometry.
#: 1177_590_539_329_181_79
#: Run 108
#: length A = 1182.600
#: length B = 593.540
#: length C = 536.990
#: length D = 333.990
#: length E = 185.910
#: thickness= 83.953
#: Warning: Failed to attach mesh to part geometry.
#: 1182_593_536_333_185_83
#: Run 109
#: length A = 1187.600
#: length B = 596.700
#: length C = 534.390
#: length D = 338.980
#: length E = 190.400
#: thickness= 88.507
#: Warning: Failed to attach mesh to part geometry.
#: 1187_596_534_338_190_88
#: Run 110
#: length A = 1166.300
#: length B = 584.940
#: length C = 543.270
#: length D = 315.900
#: length E = 170.940
#: thickness= 75.967
#: Warning: Failed to attach mesh to part geometry.
#: Warning: Failed to attach mesh to part geometry.
#: 1166_584_543_315_170_75
#: Run 111
#: length A = 1171.200
#: length B = 588.100
#: length C = 540.670
#: length D = 320.890
#: length E = 175.430
#: thickness= 80.522
#: Warning: Failed to attach mesh to part geometry.
#: 1171_588_540_320_175_80
#: Run 112
#: length A = 1176.200
#: length B = 591.260
#: length C = 538.060
#: length D = 325.880
#: length E = 179.920
#: thickness= 85.076
#: Warning: Failed to attach mesh to part geometry.
#: 1176_591_538_325_179_85
#: Run 113
#: length A = 1181.200
#: length B = 594.420
#: length C = 535.460
#: length D = 330.870
#: length E = 184.410
#: thickness= 89.631
#: Warning: Failed to attach mesh to part geometry.
#: 1181_594_535_330_184_89
#: Run 114
#: length A = 1186.100
#: length B = 597.580
#: length C = 532.860
#: length D = 335.850
#: length E = 188.900
#: thickness= 94.186
#: Warning: Failed to attach mesh to part geometry.
#: 1186_597_532_335_188_94
#: Run 115
#: length A = 1164.800
#: length B = 585.820
#: length C = 541.740
#: length D = 312.780
#: length E = 169.440
#: thickness= 81.646
#: Warning: Failed to attach mesh to part geometry.
#: Warning: Failed to attach mesh to part geometry.
#: 1164_585_541_312_169_81
#: Run 116
#: length A = 1169.800
#: length B = 588.980
#: length C = 539.130
#: length D = 317.770
#: length E = 173.930
#: thickness= 86.200
#: Warning: Failed to attach mesh to part geometry.
#: 1169_588_539_317_173_86
#: Run 117
#: length A = 1174.800
#: length B = 592.140
#: length C = 536.530
#: length D = 322.760
#: length E = 178.420
#: thickness= 90.755
#: Warning: Failed to attach mesh to part geometry.
#: 1174_592_536_322_178_90
#: Run 118
#: length A = 1179.800
#: length B = 595.300
#: length C = 533.920
#: length D = 327.740
#: length E = 182.910
#: thickness= 95.310
#: Warning: Failed to attach mesh to part geometry.
#: 1179_595_533_327_182_95
#: Run 119
#: length A = 1184.700
#: length B = 598.460
#: length C = 531.320
#: length D = 332.730
#: length E = 187.400
#: thickness= 99.864
#: Warning: Failed to attach mesh to part geometry.
#: 1184_598_531_332_187_99
#: Run 120
#: length A = 1163.400
#: length B = 586.700
#: length C = 540.200
#: length D = 309.660
#: length E = 167.930
#: thickness= 87.324
#: Warning: Failed to attach mesh to part geometry.
#: Warning: Failed to attach mesh to part geometry.
#: 1163_586_540_309_167_87
#: Run 121
#: length A = 1168.400
#: length B = 589.860
#: length C = 537.600
#: length D = 314.650
#: length E = 172.420
#: thickness= 91.879
#: Warning: Failed to attach mesh to part geometry.
#: 1168_589_537_314_172_91
#: Run 122
#: length A = 1173.400
#: length B = 593.020
#: length C = 534.990
#: length D = 319.640
#: length E = 176.910
#: thickness= 96.433
#: Warning: Failed to attach mesh to part geometry.
#: 1173_593_534_319_176_96
#: Run 123
#: length A = 1178.300
#: length B = 596.180
#: length C = 532.390
#: length D = 324.620
#: length E = 181.400
#: thickness= 100.990
#: Warning: Failed to attach mesh to part geometry.
#: 1178_596_532_324_181_100
#: Run 124
#: length A = 1183.300
#: length B = 599.340
#: length C = 529.790
#: length D = 329.610
#: length E = 185.890
#: thickness= 105.540
#: Warning: Failed to attach mesh to part geometry.
#: 1183_599_529_329_185_105
print 'RT script done'
#: RT script done
