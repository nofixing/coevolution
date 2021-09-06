package kr.coevolution.vr.event.service;

import kr.coevolution.vr.event.dto.EvEventDto;
import kr.coevolution.vr.event.domain.EvEventMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.util.List;

@Slf4j
@RequiredArgsConstructor
@Service
@Transactional(rollbackFor = {RuntimeException.class, Exception.class})
public class EvEventService {

    @Autowired
    private EvEventMapper evEventMapper;

    Logger logger = LoggerFactory.getLogger(this.getClass());

    public List<EvEventDto> miniMaxnum(EvEventDto evEventDto) {
        return evEventMapper.miniMaxnumList(evEventDto);
    }

    public List<EvEventDto> stockCodeInfo(EvEventDto evEventDto) {
        return evEventMapper.stockCodeInfo(evEventDto);
    }

    /*
    public int totalStockTodayCnt(EvEventDto evEventDto) {
        int totalCnt= 0;
        totalCnt = evEventMapper.totalStockTodayCnt(evEventDto);
        return totalCnt;
    }
    */

    public int totalStockCnt() {
        int totalCnt= 0;
        totalCnt = evEventMapper.totalStockCnt();
        return totalCnt;
    }

    public int personStockCnt(EvEventDto evEventDto) {
        int totalCnt= 0;
        totalCnt = evEventMapper.personStockCnt(evEventDto);
        return totalCnt;
    }

    public int personTodayStockCnt(EvEventDto evEventDto) {
        int totalCnt= 0;
        totalCnt = evEventMapper.personTodayStockCnt(evEventDto);
        return totalCnt;
    }

    public List<EvEventDto> miniMaxnumAfer(EvEventDto evEventDto) {
        return evEventMapper.miniMaxnumAfer(evEventDto);
    }


    public int saveEvent(EvEventDto evEventDto) {
        int return_code = 0;
        evEventMapper.saveEvent(evEventDto);
        return return_code;
    }

    public int updateEventStock(EvEventDto evEventDto) {
        int return_code = 0;
        evEventMapper.updateEventStock(evEventDto);
        return return_code;
    }

    public List<EvEventDto> mypageList(EvEventDto evEventDto) {
        return evEventMapper.S01_MYPAGE_LIST(evEventDto);
    }
}
