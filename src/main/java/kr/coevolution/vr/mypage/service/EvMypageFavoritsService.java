package kr.coevolution.vr.mypage.service;

import kr.coevolution.vr.mypage.domain.EvMypageFavoritsMapper;
import kr.coevolution.vr.mypage.dto.EvMypageFavortsRequestDto;
import kr.coevolution.vr.mypage.dto.EvMypageFavortsResponseDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@RequiredArgsConstructor
@Service
@Transactional(rollbackFor = {RuntimeException.class, Exception.class})
public class EvMypageFavoritsService {

    @Autowired
    private EvMypageFavoritsMapper evMypageFavoritsMapper;

    /**
     * Mypage 즐겨찾기 목록 표시
     * @param evMypageFavortsRequestDto
     * @return
     */
    public List<EvMypageFavortsResponseDto> mypage_favorits_list (EvMypageFavortsRequestDto evMypageFavortsRequestDto) {
        return evMypageFavoritsMapper.S01_FAVORTS(evMypageFavortsRequestDto);
    }

    public List<EvMypageFavortsResponseDto> mypage_favorits_list_count (EvMypageFavortsRequestDto evMypageFavortsRequestDto) {
        return evMypageFavoritsMapper.S02_FAVORTS(evMypageFavortsRequestDto);
    }

    /**
     * VR에서 즐겨찾기 표시
     * @param evMypageFavortsRequestDto
     * @return
     */
    public List<EvMypageFavortsResponseDto> vr_favorits (EvMypageFavortsRequestDto evMypageFavortsRequestDto) {
        return evMypageFavoritsMapper.S03_FAVORTS(evMypageFavortsRequestDto);
    }

    /**
     * 기업참가 즐겨찾기내역
     * @param evMypageFavortsRequestDto
     * @return
     */
    public List<EvMypageFavortsResponseDto> mypage_favorits_list2 (EvMypageFavortsRequestDto evMypageFavortsRequestDto) {
        return evMypageFavoritsMapper.S04_FAVORTS(evMypageFavortsRequestDto);
    }

    /**
     * 기업참가 즐겨찾기내역 건수
     * @param evMypageFavortsRequestDto
     * @return
     */
    public List<EvMypageFavortsResponseDto> mypage_favorits_list_count2 (EvMypageFavortsRequestDto evMypageFavortsRequestDto) {
        return evMypageFavoritsMapper.S05_FAVORTS(evMypageFavortsRequestDto);
    }

    /**
     * VR에서 즐겨찾기 등록 시 입력
     * @param evMypageFavortsRequestDto
     * @return
     */
    public int vr_favorits_save (EvMypageFavortsRequestDto evMypageFavortsRequestDto) {
        int return_code = 0;

        /* 즐겨찾기되어있는지 조회 */
        List<EvMypageFavortsResponseDto> list = evMypageFavoritsMapper.S03_FAVORTS(evMypageFavortsRequestDto);

        if(list.size() > 0) {
            /* 즐겨찾기 수정 (삭제) */
            evMypageFavoritsMapper.U01_FAVORTS(evMypageFavortsRequestDto);
        } else {
            /* 즐겨찾기 입력 */
            evMypageFavoritsMapper.I01_FAVORTS(evMypageFavortsRequestDto);
        }

        return return_code;
    }
}
