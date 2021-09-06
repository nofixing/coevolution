package kr.coevolution.vr.mgnt.domain;

import kr.coevolution.vr.member.dto.EvMemberLoginInfoDto;
import kr.coevolution.vr.member.dto.EvMemberLoginRequestDto;
import kr.coevolution.vr.mgnt.dto.*;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface MgntEventMapper {
    public List<EvMgntEventDto> search_person_list(EvMgntEventDto evMgntEventDto);

    public List<EvMgntEventDto> search_person_list_count(EvMgntEventDto evMgntEventDto);

    List<EvMgntEventDto> search_stock_list(EvMgntEventDto evMgntEventDto);

    List<EvMgntEventDto> search_stock_list_count(EvMgntEventDto evMgntEventDto);
}
