# Wind_Speed_Height_Conversion

  This program uses the lograithmic wind profile equation(neutral condition) to calculate wind speed at 10m height from the station height.
  Note: This program should only to be used to convert wind speed over water. For stations over land, pass the roughness length value for land cover types in to the wind_10m.ncl program.

## Objective

   - To convert wind speed over water from station height to 10m height

## Usage

   - Two NCL codes are provided:
     - calc_z0_from_ustar.ncl: Estimates roughness length from an array of wind stress.
     - wind_10m.ncl: Main driver. Uses the logarithmic wind equation to calcualte wind at 10m height.

   - With proper input file in place, type 'ncl wind_10m.ncl'. This should generate a file with the extensiton input file name+"_10m"

## Input file format:

   - YYYY MM DD HH WND

## Contact:

   - mansur@uri.edu