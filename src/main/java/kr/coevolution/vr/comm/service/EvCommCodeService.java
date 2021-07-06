package kr.coevolution.vr.comm.service;

import kr.coevolution.vr.comm.domain.EvCommCodeMapper;
import kr.coevolution.vr.comm.dto.EvCommCodeRequestDto;
import kr.coevolution.vr.comm.dto.EvCommCodeResponseDto;
import kr.coevolution.vr.comm.util.StringUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Slf4j
@Service
public class EvCommCodeService {

    @Autowired
    private EvCommCodeMapper evCommCodeMapper;

    /**
     * 공통코드조회
     * @param evCommCodeRequestDto
     * @return
     * @throws Exception
     */
    public List<EvCommCodeResponseDto> comm_code_search (EvCommCodeRequestDto evCommCodeRequestDto) {
        List<EvCommCodeResponseDto> commCodeList = evCommCodeMapper.S01_COMM_CD(evCommCodeRequestDto);
        return commCodeList;
    }

    /**
     * 공통코드조회
     * @param evCommCodeRequestDto
     * @return
     * @throws Exception
     */
    public List<EvCommCodeResponseDto> comm_code_search_sort (EvCommCodeRequestDto evCommCodeRequestDto) {
        List<EvCommCodeResponseDto> commCodeList = evCommCodeMapper.S02_COMM_CD_SORT(evCommCodeRequestDto);
        return commCodeList;
    }

    /**
     * access로저 저장
     * @param param
     * @return
     */
    public int access_log_insert (Map<String, String> param) {
        return evCommCodeMapper.I01_ACCESS_LOG(param);
    }

    /**
     * 공통코드수정
     * @param param
     * @return
     */
    public int comm_cd_update (Map<String, String> param) {

        return evCommCodeMapper.U01_COMM_CD(param);
    }

    /**
     * 공통코드수정_리스트
     * @param param
     * @return
     */
    public int comm_cd_update (List<Map<String, String>> param) {

        EvCommCodeRequestDto evCommCodeRequestDto = new EvCommCodeRequestDto();

        for(int i = 0; i < param.size(); i++) {
            Map vMap = (Map)param.get(i);

            /* 로그입력 */
            evCommCodeRequestDto.setCd_id(StringUtils.nvl(vMap.get("cd_id"),""));
            evCommCodeRequestDto.setUser_id(StringUtils.nvl(vMap.get("user_id"),""));
            evCommCodeMapper.I02_COMM_CD_LOG(evCommCodeRequestDto);

            evCommCodeMapper.U01_COMM_CD(vMap);
        }

        return 0;
    }

    /**
     * 공통코드입력
     * @param param
     * @return
     */
    public int comm_cd_insert (EvCommCodeRequestDto param) {
        return evCommCodeMapper.I02_COMM_CD(param);
    }

    /**
     * 공통코드삭제
     * @param param
     * @return
     */
    public int comm_cd_delete (EvCommCodeRequestDto param) {
        return evCommCodeMapper.D01_COMM_CD(param);
    }

    /**
     * 삭제로그입력
     * @param param
     * @return
     */
    public int comm_cd_log (EvCommCodeRequestDto param) {
        return evCommCodeMapper.I02_COMM_CD_LOG(param);
    }

}
