<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <label class="mbship_title">
        <p>MEMBER-SHIP</p>
        <ul>
          <li>01. 약관동의</li>
          <li><img src="./img/step_on.png" /></li>
          <li>02. 정보입력</li>
          <li><img src="./img/step_off.png" /></li>
          <li>03. 가입완료</li>
        </ul>
      </label>
      <fieldset class="mbship_box">
        <h3>약관동의</h3>
        <span class="agree_span">
        <label class="mbship_text">
          <input type="checkbox" id="all_agree" onclick="allagree(this.checked)" /> 의 모든 약관을 확인하고 전체 동의 합니다.
          (전체동의, 선택항목도 포함됩니다.)
        </label>
        <label class="mbship_text">
            <input type="checkbox" id="agreech1" onclick="agreeck()"><font color="red"> (필수)</font>이용약관
        </label>
        <textarea class="agree_text" id="agree1" style="resize:none;"></textarea>
        <label class="mbship_text">
            <input type="checkbox" id="agreech2" onclick="agreeck()"><font color="red"> (필수)</font> 개인정보 수집 및 이용
        </label>
        <textarea class="agree_text" type="text" id="agree2" style="resize:none;"></textarea>
        </span>
        <button type="button" class="next_btn" onclick="check()">다음단계</button>
      </fieldset>
    
<!-- 서브 화면 종료 -->
