load "calc_z0_from_ustar.ncl"

fname     = "42039h2018_split1"                                 ; input file name; needs to be changed
z_obs     = 4.1                                                 ; height at which the measurements were taken (anemometer height/met station height); needs to be changed

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;nothing needs to be changed below this line;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

nrow      = numAsciiRow(fname)                                  
ncol      = numAsciiCol(fname)                                  
U10       = new((/nrow/),float)                                  
lines     = new((/nrow/),string)
buoy_data = asciiread(fname,(/nrow,ncol/),"float")   
file_F    = fname+"_10m"                                             
system("/bin/rm -f "+file_F)


yy  = buoy_data(:,0)

mm  = buoy_data(:,1)


dd  = buoy_data(:,2)

hh1  = buoy_data(:,3)
hh = floattointeger(hh1)
u_obs  = buoy_data(:,4)


k=0.40
print("==============================================")
print("Initializing Loop")

do it = 0,nrow-1,1

y=exp(k*u_obs(it))

ust=fspan(0,5,5001)

res=0.001

z0=cal_z0_from_ustar (ust)

z0@_FillValue = 0

z0 = where(z0.ne.0,z0,z0@_FillValue)


Y= (z_obs/z0)^ust

y := conform_dims((/5001/),y,0)


dif=abs(y-Y)

locs = ind(dif.eq.min(dif))


 if (any(Y(locs)-y.gt.0)) then
            slp=(Y(locs)-Y(locs-1))/res
            dust=(y-Y(locs-1))/slp
            ust_y=ust(locs-1)+dust
 else
            slp=(Y(locs+1)-Y(locs))/res
            dust=(y-Y(locs))/slp
            ust_y=ust(locs)+dust
 end if



ust_est=ust_y

z0_ustest=cal_z0_from_ustar(ust_est)
z0_ustests=avg(z0_ustest)


ust_ests=avg(ust_y)

U10(it)=tofloat(ust_ests/k*log(10.0/z0_ustests))







end do




U11 = U10

do n = 0, nrow-1,1

lines(n) = yy(n)+"-"+mm(n)+"-"+dd(n)+"_"+sprinti("%0.2i",hh(n))+"  "+sprintf("%0.2f", U11(n))

end do

print("==============================================")
print("creating output file : "+file_F)

write_table(file_F,"a",[/lines/], \
              "%s")




