!
! Crown Copyright 2014 AWE, Copyright 2014 David Beckingsale.
!
! This file is part of CleverLeaf.
!
! CleverLeaf is free software: you can redistribute it and/or modify it under
! the terms of the GNU General Public License as published by the Free Software
! Foundation, either version 3 of the License, or (at your option) any later
! version.
!
! CleverLeaf is distributed in the hope that it will be useful, but WITHOUT ANY
! WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
! A PARTICULAR PURPOSE. See the GNU General Public License for more details.
!
! You should have received a copy of the GNU General Public License along with
! CleverLeaf. If not, see http://www.gnu.org/licenses/.
!
!>  @brief Fortran debug kernel.
!>  @author David Beckingsale
!>  @details This kernel is used for debugging, providing a convenient
!>           breakpoint for inspecting patch variables.
SUBROUTINE debug_kernel(x_min,x_max,y_min,y_max,                &
                            density0,                           &
                            density1,                           &
                            energy0,                            &
                            energy1,                            &
                            pressure,                           &
                            soundspeed,                         &
                            viscosity,                          &
                            xvel0,                              &
                            yvel0,                              &
                            xvel1,                              &
                            yvel1,                              &
                            vol_flux_x,                         &
                            vol_flux_y,                         &
                            mass_flux_x,                        &
                            mass_flux_y,                        &
                            pre_vol,                            &
                            post_vol,                           &
                            pre_mass,                           &
                            post_mass,                          &
                            advec_vol,                          &
                            post_ener,                          &
                            ener_flux)

  IMPLICIT NONE

  INTEGER :: x_min,x_max,y_min,y_max
  REAL(KIND=8), DIMENSION(x_min-2:x_max+2,y_min-2:y_max+2) :: density0
  REAL(KIND=8), DIMENSION(x_min-2:x_max+2,y_min-2:y_max+2) :: density1
  REAL(KIND=8), DIMENSION(x_min-2:x_max+2,y_min-2:y_max+2) :: energy0
  REAL(KIND=8), DIMENSION(x_min-2:x_max+2,y_min-2:y_max+2) :: energy1
  REAL(KIND=8), DIMENSION(x_min-2:x_max+2,y_min-2:y_max+2) :: pressure
  REAL(KIND=8), DIMENSION(x_min-2:x_max+2,y_min-2:y_max+2) :: soundspeed
  REAL(KIND=8), DIMENSION(x_min-2:x_max+2,y_min-2:y_max+2) :: viscosity
  REAL(KIND=8), DIMENSION(x_min-2:x_max+3,y_min-2:y_max+3) :: xvel0
  REAL(KIND=8), DIMENSION(x_min-2:x_max+3,y_min-2:y_max+3) :: yvel0
  REAL(KIND=8), DIMENSION(x_min-2:x_max+3,y_min-2:y_max+3) :: xvel1
  REAL(KIND=8), DIMENSION(x_min-2:x_max+3,y_min-2:y_max+3) :: yvel1
  REAL(KIND=8), DIMENSION(x_min-2:x_max+3,y_min-2:y_max+2) :: vol_flux_x
  REAL(KIND=8), DIMENSION(x_min-2:x_max+2,y_min-2:y_max+3) :: vol_flux_y
  REAL(KIND=8), DIMENSION(x_min-2:x_max+3,y_min-2:y_max+2) :: mass_flux_x
  REAL(KIND=8), DIMENSION(x_min-2:x_max+2,y_min-2:y_max+3) :: mass_flux_y
  REAL(KIND=8), DIMENSION(x_min-2:x_max+3,y_min-2:y_max+3) :: pre_vol
  REAL(KIND=8), DIMENSION(x_min-2:x_max+3,y_min-2:y_max+3) :: post_vol
  REAL(KIND=8), DIMENSION(x_min-2:x_max+3,y_min-2:y_max+3) :: pre_mass
  REAL(KIND=8), DIMENSION(x_min-2:x_max+3,y_min-2:y_max+3) :: post_mass
  REAL(KIND=8), DIMENSION(x_min-2:x_max+3,y_min-2:y_max+3) :: advec_vol
  REAL(KIND=8), DIMENSION(x_min-2:x_max+3,y_min-2:y_max+3) :: post_ener
  REAL(KIND=8), DIMENSION(x_min-2:x_max+3,y_min-2:y_max+3) :: ener_flux

  INTEGER :: j,k

  REAL(KIND=8) :: tmp

  DO k=y_min-2, y_max+2
    DO j=x_min-2, x_max+2

      density0(j,k) = density0(j,k)
      density1(j,k) = density1(j,k)
      energy0(j,k) = energy0(j,k)
      energy1(j,k) = energy1(j,k)

      tmp = density0(j,k)
      IF(tmp .LE. 0.0_8) THEN
        WRITE(*,*) 'Negative density at', j, k, ' = ', tmp
      ENDIF

      tmp = density1(j,k)
      IF(tmp .LE. 0.0_8) THEN
        WRITE(*,*) 'Negative density at', j, k, ' = ', tmp
      ENDIF

      tmp = energy0(j,k)
      IF(tmp .LE. 0.0_8) THEN
        WRITE(*,*) 'Negative energy at', j, k, ' = ', tmp
      ENDIF

      tmp = energy1(j,k)
      IF(tmp .LE. 0.0_8) THEN
        WRITE(*,*) 'Negative energy at', j, k, ' = ', tmp
      ENDIF

      tmp = mass_flux_x(j,k)
      IF(tmp .LT. 0.0_8 .AND. j .EQ. 483 .AND. k .EQ. 3) THEN
        WRITE(*,*) 'Negative mass flux at ', j,k, '=', tmp
      ENDIF
    ENDDO
  ENDDO

END SUBROUTINE debug_kernel
