<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <label class="mbship_title">
        <p>MEMBER-LOGIN</p>
        <ul>
          <li>로그인하시면, 회원 별 다양한 맞춤 서비스를 이용하실 수 있습니다.</li>
        </ul>
      </label>
        <form id="l" method="post" action="./login_memberok.do"  enctype="application/json">
      <fieldset class="mbship_box">
        <span class="agree_span">
        <ul class="mblogin">
            <li><img src="./img/mainlogin.png"></li>
            <li>
                <span>EXPERIENCE OF PRIDE <br> LOGIN</span>
                <span>
                    <ol class="login_ols">
                        <li><input name="mid" id="mid" type="text" class="login_input" placeholder="아이디를 입력하세요"></li>
                        <li><input name="mpw" id="mpw" type="password" class="login_input"  placeholder="패스워드를 입력하세요"></li>
                        <li><button type="button" class="login_btn1" id="login">로그인</button></li>
                        <li><button type="button" class="login_btn2" onclick="memberjoin()">회원가입</button></li>
                        <li><label><input type="checkbox" onchange="admin_login()" >admin계정으로 로그인</label></li>
                       <!--  <li style="cursor: pointer;">아이디 찾기 / 비밀번호 찾기</li> -->
                    </ol>
                </span>
            </li>
        </ul>
        </span>
      </fieldset>
        </form>