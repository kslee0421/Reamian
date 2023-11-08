<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <form id="m" method="post" action="./memberok.do" enctype="application/x-www-form-urlencoded">
    <label class="mbship_title">
        <p>MEMBER-SHIP</p>
        <ul>
          <li style="color: #000;">01. 약관동의</li>
          <li><img src="./img/step_off.png" /></li>
          <li style="color: #1B9C9E;">02. 정보입력</li>
          <li><img src="./img/step_on.png" /></li>
          <li>03. 가입완료</li>
        </ul>
      </label>
      <fieldset class="mbship_box">
        <h3>기본정보 입력 <span style="display: inline-block; font-size: 12px; vertical-align: 5px; float: right;">■ 표시는 필수 입력 항목입니다.</span></h3>
        <span class="agree_span">
        <ol class="mbinfos">
        <li><em class="ck_font">■</em> 이름</li>
        <li><input name="mname" type="text" class="mbinput1" placeholder="이름을 입력하세요"></li>
        <li><em class="ck_font">■</em> 아이디</li>
        <li>
        <input name="mid" id="mid" type="text" class="mbinput2" placeholder="6~12자의 아이디를 입력하세요">
        <button type="button" id="idch" class="mb_btn1">중복확인</button>
        </li>
        <li><em class="ck_font">■</em> 비밀번호</li>
        <li>
        <input name="mpw" type="password" class="mbinput3" placeholder="8~14자의 패스워드를 입력하세요">
        </li>
        <li><em class="ck_font">■</em> 비밀번호 확인</li>
        <li>
        <input name="mpwc" type="password" class="mbinput3" placeholder="동일한 패스워드를 입력하세요">
        </li>
        <li><em class="ck_font">■</em> 휴대전화번호</li>
        <li>
        <input name="mtel" id="mtel" type="text" class="mbinput2" placeholder="숫자만 입력하세요">
        <button type="button" id="sndbtn" class="mb_btn1" onclick="send()">인증발송</button>
        </li>
        <li><em class="ck_font">■</em> 인증번호</li>
        <li>
        <input type="text" id="code" name="code" class="mbinput2" placeholder="숫자 6자리를 입력하세요" maxlength="6">
        <input type="text" id="codech" name="codech" class="mbinput2" placeholder="숫자 6자리를 입력하세요" maxlength="6">
        <button type="button" id="frmbtn" class="mb_btn1" onclick="frm()">인증완료</button>
        </li>
        <li> 이메일</li>
        <li>
        <input id="memail" name="memail" type="text" class="mbinput3" placeholder="이메일을 입력하세요">
        </li>
        <li style="height: 125px;"><em class="ck_font">■</em> 주소</li>
        <li style="height: 120px; line-height: normal; margin-top: 5px;">
        <input id="sample4_postcode" name="postcode" type="text" class="mbinput1" placeholder="우편번호" maxlength="5" readonly>
        <button type="button" onclick="sample4_execDaumPostcode()" class="mb_btn1">주소찾기</button>
        <input id="sample4_roadAddress" name="roadAddress" type="text" class="mbinput4" placeholder="도로명 주소" readonly>
        <input id="sample4_detailAddress" name="detailAddress"type="text" class="mbinput4" placeholder="상세주소를 입력하세요">
      	<input type="hidden" name="madd">
      	<span id="guide" style="color:#999;display:none"></span>
        </li>
        <li style="height: 100px;"> 마케팅 수신여부</li>
        <li style="height: 100px;">
        <label class="ck_label"><input id="mch1" name="mch1" type="checkbox" class="mbinput5"> 이메일 </label>
        <label class="ck_label"><input id="mch2" name="mch2" type="checkbox" class="mbinput5"> 전화 </label>
        <label class="ck_label"><input id="mch3" name="mch3" type="checkbox" class="mbinput5"> 우편물 </label>
        <label class="ck_label"><input id="mch4" name="mch4" type="checkbox" class="mbinput5"> SMS (문자 메세지)</label><br>
        선택하신 정보 수신에 동의하겠습니다. (서비스, 이벤트 소식 등의 홍보/마케팅 정보를 수신하게 됩니다.)
        </li>
        </ol>
        </span>
        <span class="span_buttons">
        <button type="button" class="next_btn1_1" onclick="memberok();">회원가입</button>
        <button type="button" class="next_btn2_1" id="membercc">가입취소</button>
        </span>
      </fieldset>
     <form>