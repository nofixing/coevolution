package kr.coevolution.vr.mypage.domain;

import kr.coevolution.vr.mypage.dto.EvMypageCustCorpInfoRequestDto;
import kr.coevolution.vr.mypage.dto.EvMypageCustCorpInfoResponseDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface EvMypageCustCorpInfoMapper {

    /**
     * 내부스정보입력
     * @param param
     * @return
     */
    public int I01_CORP_INFO(EvMypageCustCorpInfoRequestDto param);

    /**
     * 내부스정보수정
     * @param param
     * @return
     */
    public int U01_CORP_INFO(EvMypageCustCorpInfoRequestDto param);

    /**
     * 내부스정보조회
     * @param param
     * @return
     */
    public List<EvMypageCustCorpInfoResponseDto> S01_CORP_INFO(EvMypageCustCorpInfoRequestDto param);
}
