undef("cal_z0_from_ustar")

function cal_z0_from_ustar(ust)


local ust_array,N,M,p_b1,p_b2,p,ustar

begin


 N   = 5001

 M   = 9
 ust_array = new ( (/M,N /), typeof(ust))

ust_array=((/ust^8, ust^7, ust^6, ust^5, ust^4, ust^3, ust^2, ust^1, ust^0/))




 p_b1 = (/-0.000098701949811,  0.001486209983407, -0.007584567778927,  0.019487056157620 \
         ,-0.029314498154105,  0.024309735869547, -0.006997554677642,  0.001258400989803, -0.000043976208055/)

 p_b2 = (/-0.002182648458354,  0.046387047659009, -0.428830523588356,  2.251251262348664 \
         ,-7.334368361013868, 15.163848944684784, -19.388290305787166,13.970227275905133, -4.319572176336596/)

 g=9.806650



 z0  = new((/5001/),float)

 z0@__FillValue = -999


 do i=0,5000     
     ustar=ust(i)
     if (.not.ismissing(ustar.lt.0.3)) then
         z0(i)=(0.0185/g) * ustar^2
     elseif (.not.ismissing(ustar.lt. 2.35)) then
         z0(i)=sum( p_b1*ust_array(:,i) )
     elseif (.not.ismissing(ustar.lt.3)) then
         z0(i)=sum( p_b2*ust_array(:,i) ) 
     else
         z0(i)=0.001305
     end if

 end do

return(z0)

end