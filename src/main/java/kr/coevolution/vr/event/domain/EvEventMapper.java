package kr.coevolution.vr.event.domain;
import kr.coevolution.vr.event.dto.EvEventResposeDto;
import org.apache.ibatis.annotations.Mapper;
import kr.coevolution.vr.event.dto.EvEventDto;
import java.util.List;


@Mapper
public interface EvEventMapper {

    List<EvEventDto> miniMaxnumList(EvEventDto evEventDto);

    List<EvEventDto> stockCodeInfo(EvEventDto evEventDto);

    //int totalStockTodayCnt(EvEventDto evEventDto);

    int totalStockCnt();

    int personStockCnt(EvEventDto evEventDto);

    int personTodayStockCnt(EvEventDto evEventDto);

    List<EvEventDto> miniMaxnumAfer(EvEventDto evEventDto);

    void saveEvent(EvEventDto evEventDto);

    void updateEventStock(EvEventDto evEventDto);

    /**
     * 마이페이지 리스트
     * @param evEventDto
     * @return
     */
    List<EvEventResposeDto> S01_MYPAGE_LIST(EvEventDto evEventDto);
}



