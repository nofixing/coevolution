package kr.coevolution.vr.mypage.service;

import kr.coevolution.vr.member.domain.EvMemberMapper;
import kr.coevolution.vr.member.dto.EvMemberBadgeRequestDto;
import kr.coevolution.vr.mypage.dto.EvMypageBadgeRequestDto;
import kr.coevolution.vr.mypage.dto.EvMypageBadgeResponseDto;
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
public class EvMypageBadgeService {

    @Autowired
    private EvMemberMapper evMemberMapper; /* 뱃지 Mapper */

    /**
     * 마이페이지 뱃지 리스트
     * @param evMypageBadgeRequestDto
     * @return
     */
    public List<EvMypageBadgeResponseDto> mypage_badge_list (EvMypageBadgeRequestDto evMypageBadgeRequestDto) {
        return evMemberMapper.S01_BADGE(evMypageBadgeRequestDto);
    }

    /**
     * 마이페이지 뱃지 개수
     * @param evMypageBadgeRequestDto
     * @return
     */
    public List<EvMypageBadgeResponseDto> mypage_badge_list_count (EvMypageBadgeRequestDto evMypageBadgeRequestDto) {
        return evMemberMapper.S02_BADGE(evMypageBadgeRequestDto);
    }

    /**
     * VR 뱃지 표시
     * @param evMemberBadgeRequestDto
     * @return
     */
    public List<EvMypageBadgeResponseDto> vr_badge (EvMemberBadgeRequestDto evMemberBadgeRequestDto) {
        return evMemberMapper.S03_BADGE(evMemberBadgeRequestDto);
    }

    /**
     * 마이페이지 뱃지 리스트 - 기업참가
     * @param evMypageBadgeRequestDto
     * @return
     */
    public List<EvMypageBadgeResponseDto> mypage_badge_list2 (EvMypageBadgeRequestDto evMypageBadgeRequestDto) {
        return evMemberMapper.S04_BADGE(evMypageBadgeRequestDto);
    }

    /**
     * 마이페이지 뱃지 개수  - 기업참가
     * @param evMypageBadgeRequestDto
     * @return
     */
    public List<EvMypageBadgeResponseDto> mypage_badge_list_count2 (EvMypageBadgeRequestDto evMypageBadgeRequestDto) {
        return evMemberMapper.S05_BADGE(evMypageBadgeRequestDto);
    }

    /**
     * 기업정보에서 뱃지를 입력 및 회수한다.
     * @param evMemberBadgeRequestDto
     * @return
     */
    public int vr_badge_save (EvMemberBadgeRequestDto evMemberBadgeRequestDto) {
        int return_code = 0;

        /* 뱃지 등록여부 조회 sum_badge_cnt = 0 : 미등록, sum_badge_cnt > 0 : 뱃지 등록 */
        List<EvMypageBadgeResponseDto> list = evMemberMapper.S03_BADGE(evMemberBadgeRequestDto);

        int sumBadge = 0;
        if(list.size() > 0) {
            sumBadge = list.get(0).getSum_badge_cnt();
        }

        if(sumBadge > 0) {
            /* 뱃지 사용 */
            evMemberBadgeRequestDto.setBadge_clsf_cd("211003");
            evMemberBadgeRequestDto.setBadge_cnt("-1");
            evMemberMapper.I01_BADGE(evMemberBadgeRequestDto);
        } else {
            /* 뱃지 회수 */
            evMemberBadgeRequestDto.setBadge_clsf_cd("211004");
            evMemberBadgeRequestDto.setBadge_cnt("1");
            evMemberMapper.I01_BADGE(evMemberBadgeRequestDto);
        }

        return return_code;
    }
}
