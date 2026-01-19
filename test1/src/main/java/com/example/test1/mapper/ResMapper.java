package com.example.test1.mapper;

import com.example.test1.model.Reservation;
import com.example.test1.model.reservation.Poi;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ResMapper {

    // 예약 단건 조회
    Reservation selectReservationByResNum(@Param("resNum") Long resNum);

    // 예약/POI 저장
    int insertReservation(Reservation reservation);
    int insertPoi(Poi poi);

    // 예약별 POI 목록
    List<Poi> selectPoisByResNum(@Param("resNum") Long resNum);

    // 결제 금액 조회 : accom + food
    Long selectPayAmount(@Param("resNum") Long resNum);

    // 코스명/메모 업데이트 (DESCRIPT 포함)
    int updatePackname(@Param("resNum") Long resNum,
                       @Param("packName") String packName,
                       @Param("userId") String userId,
                       @Param("descript") String descript);

    // 삭제
    int deleteReservation(@Param("resNum") Long resNum);
    int deletePoisByResNum(@Param("resNum") Long resNum);

    // (신규) 숙소 예약 정보 저장 (RESERVATION_ACC)
    int insertReservationAcc(@Param("resNum") Long resNum,
                             @Param("accomName") String accomName,
                             @Param("reserver") String reserver,
                             @Param("contentId") Long contentId);
}
