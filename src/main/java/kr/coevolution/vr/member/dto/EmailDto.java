package kr.coevolution.vr.member.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class EmailDto {

    private String title;
    private String content;
    private String sender;
    private String receiver;

}
