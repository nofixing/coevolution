package kr.coevolution.vr.mypage.domain;

import kr.coevolution.vr.mypage.dto.EvMypageFavortsRequestDto;
import kr.coevolution.vr.mypage.dto.EvMypageFavortsResponseDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface EvMypageFavoritsMapper {

    /**
     * 마이페이지 즐겨찾기 조회
     * @param param
     * @return
     */
    public List<EvMypageFavortsResponseDto> S01_FAVORTS(EvMypageFavortsRequestDto param);

    /**
     * 총 개수
     * @param param
     * @return
     */
    public List<EvMypageFavortsResponseDto> S02_FAVORTS(EvMypageFavortsRequestDto param);

    /**
     * 기업정보 즐겨찾기 조회
     * @param param
     * @return
     */
    public List<EvMypageFavortsResponseDto> S03_FAVORTS(EvMypageFavortsRequestDto param);

    /**
     * 마이페이지 즐겨찾기 조회 (참가)
     * @param param
     * @return
     */
    public List<EvMypageFavortsResponseDto> S04_FAVORTS(EvMypageFavortsRequestDto param);

    /**
     * 총 개수 (참가)
     * @param param
     * @return
     */
    public List<EvMypageFavortsResponseDto> S05_FAVORTS(EvMypageFavortsRequestDto param);

    /**
     * 즐겨찾기 입력
     * @param param
     * @return
     */
    public int I01_FAVORTS(EvMypageFavortsRequestDto param);

    /**
     * 즐겨찾기 수정 (삭제처리)
     * @param param
     * @return
     */
    public int U01_FAVORTS(EvMypageFavortsRequestDto param);
}
