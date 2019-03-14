# Scoring methodology

In all future procurements, a subset of the benchmarks in this repository will be selected based on the expected use of the new service.  Scores will be pitted against each other, weighting will be applied to them and bidders will be expected to:

1. Populate a provided spreadsheet with the desired value.
2. Provide a log file for the qualifying run for debugging purposes.

**Note** - Scores will be compared against reference systems and scores which fall outside the expected range will be subject to clarification questions and if sufficient explanation is not provided, disqualification. 

As an example of how this would work, imagine a tender for a new machine with three benchmarks: Pi, Mandelbrot, and Numpy.  Four vendors (Cyberdyne Systems, Gibson, Multivac and HAL) all bid and provide the following scores:


|Vendor   | Pi  | Mandelbrot | Numpy | 
|---------|-----|------------|-------|
|Cyberdyne| 1.2 | 2.5        | 0.6   | 
|Gibson   | 1.3 | 2.3        | 0.7   |
|HAL      | 1.0 | 2          | 0.1   |
|Multivac | 1.3 | 2.4        | 0.73  |


The benchmarks are weighted 50, 25 and 25 respectively, and for each benchmark, a vendor's score is marked relative to the highest score:

```
  MY_score = MY_Score   *  weight
             ---------
             MAX_Score
```

The scores then work out as:

|Score    | Pi           |Mandelbrot|Numpy        |Total        |
|---------|--------------|----------|-------------|-------------|
|Cyberdyne|46.1538461538 | 25       |20.5479452055|91.7017913593|
|Gibson	  |50            | 23       |23.9726027397|96.9726027397|
|HAL      |38.4615384615 | 20       |3.4246575342 |61.8861959958|
|Multivac |50            | 24       |25           |99           |

*Benchmarks which are failed score 0.  This may be determined from the log files or not providing a result.*

