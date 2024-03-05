program dc_1
    implicit none



call do_mul

call dc_mul


    contains
    subroutine do_mul()

        real :: x(4)
        real :: y(4)
        integer :: i
    
        do i=1,4
            y(i) = x(i) * x(i) 
        end do

        end subroutine

    subroutine dc_mul()

        real :: x(4)
        real :: y(4)
        integer :: i
    
        do concurrent(i = 1: 4) 
            y(i) = x(i) * x(i) 
        end do

        end subroutine

end program
