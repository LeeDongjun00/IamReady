package com.example.test1.model;

import lombok.Data;

@Data
public class Lodge {
	private int ResNum;
	private String AccomName;
	private String RoomName;
	private String Reserver;
	private String CheckIn;
	private String CheckOut;
	private int StayDays;
	private int PeopleCnt;
	private int TotalPrice;
		
	private String PaymentUid;
	private String PaymentStatus;
	
	private String Cdatetime;
	private String Udatetime;
}
