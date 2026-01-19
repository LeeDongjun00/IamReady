package com.example.test1.mapper;

public interface ReservationAccMapper {
	int inserReservationAcc(
			Long resNum,
			String accName,
			String reserver,
			Long cointentId
	);
	
}
