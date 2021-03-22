package kr.coevolution.vr.mypage;

import kr.coevolution.vr.comm.dto.EvFileAttachRequestDto;
import kr.coevolution.vr.comm.dto.EvFileAttachResponseDto;
import kr.coevolution.vr.comm.service.EvFileAttachService;
import kr.coevolution.vr.comm.util.StringUtils;
import kr.coevolution.vr.member.dto.EvMemberLoginInfoDto;
import kr.coevolution.vr.mypage.dto.EvMypageCustCorpInfoRequestDto;
import kr.coevolution.vr.mypage.dto.EvMypageCustCorpInfoResponseDto;
import kr.coevolution.vr.mypage.dto.EvMypageFavortsRequestDto;
import kr.coevolution.vr.mypage.dto.EvMypageFavortsResponseDto;
import kr.coevolution.vr.mypage.service.EvMypageCustCorpInfoService;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@NoArgsConstructor
@RestController
public class EvMypageCustCorpInfoController {

    @Autowired
    private EvMypageCustCorpInfoService evMypageCustCorpInfoService;

    @Autowired
    private EvFileAttachService evFileAttachService;

    @PostMapping("/mypage/corpinfo")
    public Map<String,Object> mypage_corpinfo (@RequestBody EvMypageCustCorpInfoRequestDto evMypageCustCorpInfoRequestDto, HttpServletRequest request) {
        Map resposeResult = new HashMap();

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

            evMypageCustCorpInfoRequestDto.setCust_id(loginInfoDto.getCust_id());

            /* 내 부스정보 조회 */
            List<EvMypageCustCorpInfoResponseDto> list = evMypageCustCorpInfoService.mypage_cust_corp_info(evMypageCustCorpInfoRequestDto);

            /* 내 부스정보 첨부파일 조회 */
            EvFileAttachRequestDto evFileAttachRequestDto = new EvFileAttachRequestDto();
            List<EvFileAttachResponseDto> attachList = evFileAttachService.file_attach_list(evFileAttachRequestDto);

            resposeResult.put("list", list);
            resposeResult.put("attachList", attachList);
            resposeResult.put("result_code", "0");
            resposeResult.put("result_msg", "성공!!");

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return resposeResult;
    }

    /**
     * 내부스정보 저장
     * @param evMypageCustCorpInfoRequestDto
     * @param request
     * @return
     */
    @PostMapping("/mypage/corpsave")
    public Map<String,Object> mypage_corpsave (@RequestBody EvMypageCustCorpInfoRequestDto evMypageCustCorpInfoRequestDto, HttpServletRequest request) {
        Map resposeResult = new HashMap();

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

            evMypageCustCorpInfoRequestDto.setCust_id(loginInfoDto.getCust_id());

            /* 내 부스정보 저장 */
            evMypageCustCorpInfoService.mypage_cust_corp_save(evMypageCustCorpInfoRequestDto);

            resposeResult.put("result_code", "0");
            resposeResult.put("result_msg", "성공!!");

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "조회실패!!");

            e.printStackTrace();
        }

        return resposeResult;
    }

    /**
     * 내부스정보-첨부파일 저당
     * @param evMypageCustCorpInfoRequestDto
     * @param request
     * @return
     */
    @PostMapping("/mypage/corpattach")
    public Map<String,Object> mypage_corpattach (EvMypageCustCorpInfoRequestDto evMypageCustCorpInfoRequestDto, @RequestPart List<MultipartFile> files,  HttpServletRequest request) {
        Map resposeResult = new HashMap();

        try {
            /* 로그인정보 */
            HttpSession httpSession = request.getSession();
            EvMemberLoginInfoDto loginInfoDto = (EvMemberLoginInfoDto)httpSession.getAttribute(StringUtils.login_session);

            evMypageCustCorpInfoRequestDto.setBoard_id(loginInfoDto.getCust_seq());
            evMypageCustCorpInfoRequestDto.setCust_id(loginInfoDto.getCust_id());
            evMypageCustCorpInfoRequestDto.setUser_id(loginInfoDto.getCust_id());

            /* 내 부스정보 첨부파일 업로드 */
            int return_code = evMypageCustCorpInfoService.mypage_cust_corp_file(evMypageCustCorpInfoRequestDto, files);

            if(return_code != 0) {
                new RuntimeException("-1");
            } else {
                resposeResult.put("result_code", "0");
                resposeResult.put("result_msg", "성공!!");
            }

        } catch (Exception e) {

            resposeResult.put("result_code", "-99");
            resposeResult.put("result_msg", "업로드실패!!");

            e.printStackTrace();
        }

        return resposeResult;
    }
}
