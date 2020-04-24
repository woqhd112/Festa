/*
 * pagenation
 */

var page=1;
var totalCount;
var displayRow3
var beginPage;		
var endPage;		
var prev;				
var next;	
var totalPage;
var startnum;		
var endnum;			
var displayPage;

function pagenation(displayRow,displayPage1,totalcount){
	displayRow3=displayRow;	
	displayPage=displayPage1;
	totalCount=totalcount;
}
//함수실행
function funcLoad(tag){
	paging(page);
	pageView();
	rowView(tag);
}

//페이징함수 
function paging(page){
	startnum=(page-1)*displayRow3+1;
	endnum=page*displayRow3;
	
	totalPage=Math.floor(totalCount/displayRow3);
	
	if(totalCount%displayRow3!=0){
		totalPage+=1;
	}
	
	endPage = Math.floor((page+(displayPage-1))/displayPage)*displayPage;
	beginPage = endPage - (displayPage-1);
	
	if(totalPage<endPage&&totalPage==page){
		endPage=totalPage;
		next=false;
	}else if(totalPage<endPage&&totalPage>page) {
		endPage=totalPage;
		next=true;
	}else if(totalPage==endPage&&totalPage==page){
		next=false;
	}else {
		next=true;
	}
	if(beginPage==1){
		prev=false;
	}else{
		prev=true;
	}
}

//페이지뷰 함수
function pageView(){
	if(totalCount!=0){
		if(page==1){
			$('.fstPage ul').html('<li><a class="pg_start off"><em class="snd_only">맨 앞으로</em></a></li>'+
			'<li><a class="pg_prev off"><em class="snd_only">이전 페이지</em></a></li>');
		}else{
			$('.fstPage ul').html('<li><a class="pg_start" href=""><em class="snd_only">맨 앞으로</em></a></li>'+
			'<li><a class="pg_prev" href=""><em class="snd_only">이전 페이지</em></a></li>');
		}
		for(var i=beginPage; i<=endPage; i++){
			if(i==page){
				$('.fstPage ul').append('<li><b>'+i+'</b></li>');
			}else{
				$('.fstPage ul').append('<li><a href="">'+i+'</a></li>');
			}
		}
		if(next==true){
			$('.fstPage ul').append('<li><a class="pg_next" href=""><em class="snd_only">다음 페이지</em></a></li>'+
			'<li><a class="pg_end" href=""><em class="snd_only">맨 끝으로</em></a></li>');
		}else{
			$('.fstPage ul').append('<li><a class="pg_next off"><em class="snd_only">다음 페이지</em></a></li>'+
			'<li><a class="pg_end off"><em class="snd_only">맨 끝으로</em></a></li>');
		}
	}
}

//로우뷰 함수
function rowView(tag){
	tag.hide();
	for(var i=startnum; i<=endnum; i++){
		tag.eq(i-1).show();
	}
}

//조건처리식
function ifPage(pagetext){
	var pageText=$(pagetext).text();
	//다음버튼 눌렀을경우
	if(pageText=='다음 페이지'){
		if(page==totalPage){
			return false;						
		}else{
			page+=1;
		}
	//이전버튼 눌렀을경우
	}else if(pageText=='이전 페이지'){
		if(page==1){
			return false;						
		}else{
			page-=1;
		}
	//맨끝버튼 눌렀을경우
	}else if(pageText=='맨 끝으로'){
		if(totalPage==endPage){
			page=endPage;
		}else if(totalPage!=endPage){
			page=endPage+1;
		}
	//맨앞버튼 눌렀을경우
	}else if(pageText=='맨 앞으로'){
		if(beginPage==1){
			page=beginPage;
		}else if(beginPage!=1){
			page=beginPage-1;
		}
	//그외 숫자버튼 눌렀을경우
	}else{
		page=Number(pageText);
	}
}
/*
 * pagenation end
 */


/*
 * feed more
 */

function feedList(data,view,pronum,prophoto,logincheck){
	if(view=='search'){
		$(data).each(function(index){
			//해시태그 조건부
			var hash1=data[index].httitle1;
			var hash2=data[index].httitle2;
			var hash3=data[index].httitle3;
			var hashtag;
			if(hash1==''&&hash2==''&&hash3==''){
				hashtag='';
			}else if(hash1==''&&hash2==''&&hash3!=''){
				hashtag=hash3;
			}else if(hash1==''&&hash2!=''&&hash3!=''){
				hashtag=hash2+' #'+hash3;
			}else if(hash1==''&&hash2!=''&&hash3==''){
				hashtag=hash2;
			}else if(hash1!=''&&hash2==''&&hash3==''){
				hashtag=hash1;
			}else if(hash1!=''&&hash2==''&&hash3!=''){
				hashtag=hash1+' #'+hash3;
			}else if(hash1!=''&&hash2!=''&&hash3==''){
				hashtag=hash1+' #'+hash2;
			}else if(hash1!=''&hash2!=''&&hash3!=''){
				hashtag=hash1+' #'+hash2+' #'+hash3;
			}
			//공통사항인값 선언
			var photo;
			var num;
			var content;
			var total;
			var thums;
			var photos;
			var parameter;
			var tag;
			var feedLi;
			var prophoto = data[index].profile.prophoto;
			var prophototag;
			if(prophoto==null||prophoto==''||prophoto==undefined||prophoto.isEmpty){
				prophototag='<img src="/festa/resources/images/thumb/no_profile.png" alt="피드 썸네일" onload="squareTrim($(this), 30)">';
			}else{
				prophototag='<img src="/festa/resources/upload/'+data[index].profile.prophoto+'" alt="피드 썸네일" onload="squareTrim($(this), 30)">';
			}
		
				//개인피드일때
				if(data[index].gpnum==0){
					//개인피드값 주입
					num=data[index].mpnum;
					content=data[index].mpcontent;
					total=data[index].mptotal;
					tag='<a class="text box btn_pop" href="/festa/search/feed?mpnum='+num+'">';
					//사진이 ''이 아닐때 사진추가
					if(data[index].mpphoto!=''){
						photo=data[index].mpphoto;
						photos=photo.split(',');
						photo=photos[0];
						feedLi = '<li class="half">';
						thums='<a class="thumb box btn_pop" href="/festa/search/feed?mpnum='+num+'"><span class="fd_thumb"><img src="/festa/resources/upload/'+photo+'" alt="피드 썸네일" onload="squareTrim($(this), 100)"></span></a>';
					}else{
						feedLi = '<li>';
						thums='';
					}
					//개인피드일때 그룹파라미터값 없으니 ''
					parameter='';
					
				//그룹피드일때
				}else{
					//그룹피드값 주입
					num=data[index].gpnum;
					content=data[index].gpcontent;
					total=data[index].gptotal;
					tag='<a class="text box btn_pop" href="/festa/search/feed?gpnum='+num+'">'
					//사진이 ''이 아닐때 사진추가
					if(data[index].gpphoto!=''){
						photo=data[index].gpphoto;
						photos=photo.split(',');
						photo=photos[0];
						feedLi = '<li class="half">';
						thums='<a class="thumb box btn_pop" href="/festa/search/feed?gpnum='+num+'"><span class="fd_thumb"><img src="/festa/resources/upload/'+photo+'" alt="피드 썸네일" onload="squareTrim($(this), 100)"></span></a>';
					}else{
						feedLi = '<li>';
						thums='';
					}
					//그룹피드일때 그룹파라미터값 있으니 로그인일떄 아닐때 조건처리
					if(logincheck!=''){
						parameter='<a class="fd_group" href="/festa/group/?grnum='+data[index].grnum+'&pronum='+pronum+'">'+data[index].group.grname+'</a>';
					}else{
						parameter='<a class="fd_group" href="/festa/group/?grnum='+data[index].grnum+'">'+data[index].group.grname+'</a>';
					}
				}
				//json데이터 append 부분
				$('.feed_list').append(feedLi
				+tag
				+'<span class="fd_hashtag">'+hashtag+'</span><span class="fd_content">'+content
				+'</span></a>'
				+thums
				+'<p class="info box btn_pop">'
				+'<a class="pf_picture" href="/festa/user/?pronum='+data[index].pronum+'">'
				+prophototag
				+'</a><a class="fd_name" href="/festa/user/?pronum='+data[index].pronum+'">'+data[index].profile.proname+'</a>'
				+'<span class="fd_liked">'+data[index].good+'</span>'
				+parameter
				+'<span class="fd_comment">'+total+'</span>'
				+'<span class="fd_date">'+data[index].date1+'</span></p></li>');
		});
	}else if(view=='hot'){
		console.log(prophoto);
		$(data[0]).each(function(index){
			
			var hash1=data[0][index].httitle1;
			var hash2=data[0][index].httitle2;
			var hash3=data[0][index].httitle3;
			var hashtag;
			var likeBtn;
			var reportBtn;
			var editBtn;
			var delBtn;
			var moreBtn;
			var msgForm;
			var photo;
			var photos;
			var grname;
			var thums;
			var cmmtList='';
			var feedView;
			var cmmtCnt=0;
			var author;
			var num;
			var content;
			var prophototag;
			var feedprophototag;
			var msgTag;
			var grnum;
			
			//해시태그 선언부
			if(hash1==''&&hash2==''&&hash3==''){
				hashtag='';
			}else if(hash1==''&&hash2==''&&hash3!=''){
				hashtag='<li><a href="/festa/search/?keyword='+hash3+'">'+hash3+'</a></li>';
			}else if(hash1==''&&hash2!=''&&hash3!=''){
				hashtag='<li><a href="/festa/search/?keyword='+hash3+'">'+hash3+'</a></li>'
				+'<li><a href="${root }search/?keyword='+hash2+'">'+hash2+'</a></li>';
			}else if(hash1==''&&hash2!=''&&hash3==''){
				hashtag='<li><a href="/festa/search/?keyword='+hash2+'">'+hash2+'</a></li>';
			}else if(hash1!=''&&hash2==''&&hash3==''){
				hashtag='<li><a href="/festa/search/?keyword='+hash1+'">'+hash1+'</a></li>';
			}else if(hash1!=''&&hash2==''&&hash3!=''){
				hashtag='<li><a href="/festa/search/?keyword='+hash1+'">'+hash1+'</a></li>'
				+'<li><a href="/festa/search/?keyword='+hash3+'">'+hash3+'</a></li>';
			}else if(hash1!=''&&hash2!=''&&hash3==''){
				hashtag='<li><a href="/festa/search/?keyword='+hash1+'">'+hash1+'</a></li>'
				+'<li><a href="/festa/search/?keyword='+hash2+'">'+hash2+'</a></li>';
			}else if(hash1!=''&hash2!=''&&hash3!=''){
				hashtag='<li><a href="/festa/search/?keyword='+hash1+'">'+hash1+'</a></li>'
				+'<li><a href="/festa/search/?keyword='+hash2+'">'+hash2+'</a></li>'
				+'<li><a href="/festa/search/?keyword='+hash3+'">'+hash3+'</a></li>';
			}
			
			//개인피드일때
			if(data[0][index].gpnum==0){
				grnum='';
				grname='';
				author=data[0][index].mpauthor;
				num=data[0][index].mpnum;
				content=data[0][index].mpcontent;
				photo=data[0][index].mpphoto;
				msgTag='<input type="text" class="msg_txt" name="mccontent" placeholder="메세지를 입력해주세요" required="required">';
				//로그인상태일때
				if(logincheck!=''){
					editBtn='<li><a href="/festa/hot/maker?mpnum='+num+'" class="btn_pop btn_edit"><em class="snd_only">수정하기</em></a></li>';
					if(data[3]!=''){
						$(data[3]).each(function(idx){
							//좋아요목록의 개인피드번호와 가져온개인피드번호가 같을때 하트버튼생성
							if(data[3][idx].mpnum==num){
								likeBtn='<li><button class="btn_liked act"><em class="snd_only">하트</em></button></li>';
							//아닐때 빈하트
							}else{
								likeBtn='<li><button class="btn_liked"><em class="snd_only">하트</em></button></li>';
							}										
						});
					}else{
						likeBtn='<li><button class="btn_liked"><em class="snd_only">하트</em></button></li>';
					}
				}
				//게시글갯수가 3개초과일때 댓글더보기버튼 생성
				if(data[0][index].mptotal>3){
					moreBtn='<button class="cmt_btn_more mc"><span class="snd_only">1</span>댓글 더 보기</button>';
				//3개이하일때 댓글더보기버튼 삭제
				}else{
					moreBtn='';
				}
				//해당피드의 댓글출력
				$(data[2]).each(function(index1){
					var cmmtprophoto=data[2][index1].profile.prophoto;
					var cmmtprophototag;
					if(cmmtprophoto==null||cmmtprophoto==''||cmmtprophoto.isEmpty||cmmtprophoto==undefined){
						cmmtprophototag='<img src="/festa/resources/images/thumb/no_profile.png" alt="'+data[2][index1].profile.proname+'님의 프로필 썸네일" onload="squareTrim($(this), 30)">';
					}else{
						cmmtprophototag='<img src="/festa/resources/upload/'+data[2][index1].profile.prophoto+'" alt="'+data[2][index1].profile.proname+'님의 프로필 썸네일" onload="squareTrim($(this), 30)">';
					}
					
					var cmmtDelBtn;
					//해당피드번호와 댓글의피드번호가 같을때 댓글리스트작성
					if(num==data[2][index1].mpnum){
						//로그인상태이고 회원번호와 댓글작성자번호가 같을때 삭제버튼 생성
						if(logincheck!=''&&pronum==data[2][index1].pronum){
							cmmtDelBtn='<button class="btn_pop btn_delete btn_cmmt" data-layer="delete_cmmt" data-value="'+data[2][index1].mcnum+'"><em class="snd_only">삭제하기</em></button>';
						//아닐때 삭제버튼 삭제
						}else{
							cmmtDelBtn='';
						}
						
						cmmtList+='<li>'
							+'<a href="/festa/user/?pronum='+data[2][index1].pronum+'" class="pf_picture">'
							+cmmtprophototag
							+'</a>'
							+'<p class="cmt_content">'
							+'<a href="/festa/user/?pronum='+data[2][index1].pronum+'" class="cmt_name">'+data[2][index1].mcauthor+'</a>&nbsp;'
							+data[2][index1].mccontent
							+'<span class="cmt_date">'+data[2][index1].mcdate1+'</span>'
							+cmmtDelBtn
							+'</p></li>';
						cmmtCnt++;
					}
					if(cmmtCnt==3){
						return false;
					}
				});
			}else{
				grnum='<input type="hidden" value="'+data[0][index].grnum+'">';
				author=data[0][index].gpauthor;
				num=data[0][index].gpnum;
				content=data[0][index].gpcontent;
				photo=data[0][index].gpphoto;
				msgTag='<input type="text" class="msg_txt" name="gccontent" placeholder="메세지를 입력해주세요" required="required">';
				//로그인상태일때
				//로그인 그룹접속시 프로필번호생성
				if(logincheck!=''){
					editBtn='<li><a href="/festa/hot/maker?gpnum='+num+'" class="btn_pop btn_edit"><em class="snd_only">수정하기</em></a></li>';
					grname='<a href="/festa/group/?grnum='+data[0][index].grnum+'&pronum='+pronum+'">'
						+'<span class="fd_group">'+data[0][index].group.grname+'</span>'
						+'</a>';
					if(data[3]!=''){
						$(data[3]).each(function(idx){
							//좋아요목록의 개인피드번호와 가져온개인피드번호가 같을때 하트버튼생성
							if(data[3][idx].gpnum==num){
								likeBtn='<li><button class="btn_liked act"><em class="snd_only">하트</em></button></li>';
							//아닐때 빈하트
							}else{
								likeBtn='<li><button class="btn_liked"><em class="snd_only">하트</em></button></li>';
							}
						});
					}else{
						likeBtn='<li><button class="btn_liked"><em class="snd_only">하트</em></button></li>';
					}
					
				//로그인상태가 아닐때 댓글작성태그 삭제
				//비로그인 그룹접속시 프로필번호삭제
				}else{
					grname='<a href="/festa/group/?grnum='+data[0][index].grnum+'">'
						+'<span class="fd_group">'+data[0][index].group.grname+'</span>'
						+'</a>';
				}
				//게시글갯수가 3개초과일때 댓글더보기버튼 생성
				if(data[0][index].gptotal>3){
					moreBtn='<button class="cmt_btn_more gc"><span class="snd_only">1</span>댓글 더 보기</button>';
				//3개이하일때 댓글더보기버튼 삭제
				}else{
					moreBtn='';
				}
				
				//해당피드의 댓글출력
				$(data[1]).each(function(index2){
					var cmmtprophoto=data[1][index2].profile.prophoto;
					var cmmtprophototag;
					if(cmmtprophoto==null||cmmtprophoto==''||cmmtprophoto.isEmpty||cmmtprophoto==undefined){
						cmmtprophototag='<img src="/festa/resources/images/thumb/no_profile.png" alt="'+data[1][index2].profile.proname+'님의 프로필 썸네일" onload="squareTrim($(this), 30)">';
					}else{
						cmmtprophototag='<img src="/festa/resources/upload/'+data[1][index2].profile.prophoto+'" alt="'+data[1][index2].profile.proname+'님의 프로필 썸네일" onload="squareTrim($(this), 30)">';
					}
					var cmmtDelBtn;
					//해당피드번호와 댓글의피드번호가 같을때 댓글리스트작성
					if(num==data[1][index2].gpnum){
						//로그인상태이고 회원번호와 댓글작성자번호가 같을때 삭제버튼 생성
						if(logincheck!=''&&pronum==data[1][index2].pronum){
							cmmtDelBtn='<button class="btn_pop btn_delete btn_cmmt" data-layer="delete_cmmt" data-value="'+data[1][index2].gcnum+'"><em class="snd_only">삭제하기</em></button>';
						//아닐때 삭제버튼 삭제
						}else{
							cmmtDelBtn='';
						}
						
						cmmtList+='<li>'
							+'<a href="/festa/user/?pronum='+data[1][index2].pronum+'" class="pf_picture">'
							+cmmtprophototag
							+'</a>'
							+'<p class="cmt_content">'
							+'<a href="/festa/user/?pronum='+data[1][index2].pronum+'" class="cmt_name">'+data[1][index2].gcauthor+'</a>&nbsp;'
							+data[1][index2].gccontent
							+'<span class="cmt_date">'+data[1][index2].gcdate1+'</span>'
							+cmmtDelBtn
							+'</p></li>';
						cmmtCnt++;
					}
					if(cmmtCnt==3){
						return false;
					}
				});
				
			}
			
			if(logincheck!=''){
				if(prophoto==null||prophoto==''||prophoto==undefined||prophoto.isEmpty){
					console.log('접근1');
					prophototag='<img src="/festa/resources/images/thumb/no_profile.png" alt="나의 프로필 썸네일" onload="squareTrim($(this), 30)">';
				}else{
					console.log('접근2');
					prophototag='<img src="/festa/resources/upload/'+prophoto+'" alt="나의 프로필 썸네일" onload="squareTrim($(this), 30)">';
				}
				//로그인회원번호와 피드작성자번호가 같지않을때 신고버튼생성//수정,삭제버튼삭제
				if(pronum!=data[0][index].pronum){
					reportBtn='<li><a href="/festa/hot/report?gpnum='+num+'&profile.pronum='+data[0][index].pronum+'&profile.proname='+data[0][index].profile.proname+'&profile.proid='+data[0][index].profile.proid+'" class="btn_pop btn_report"><em class="snd_only">신고하기</em></a></li>';
					editBtn='';
					delBtn='';
				//같을때 신고버튼삭제//수정,삭제버튼생성
				}else{
					reportBtn='';
					delBtn='<li><button class="btn_pop btn_delete btn_feed" data-layer="delete_feed" data-value="'+num+'"><em class="snd_only">삭제하기</em></button></li>';
				}
				//로그인상태일때 댓글작성태그 생성
				msgForm='<form class="message_form">'
						+'<a class="pf_picture" href="/festa/user/?pronum='+pronum+'">'
						+prophototag
						+'</a>'
						+'<p class="msg_input">'
						+msgTag
						+'<button type="submit" class="btn_send"><em class="snd_only">전송</em></button>'
						+'</p>'
						+'</form>';
			}else{
				editBtn='';
				delBtn='';
				reportBtn='';
				likeBtn='';
				msgForm='';
			}
			//해당피드사진이 존재할때 사진등록
			if(photo!=''){
				feedView='<div class="feed_viewer half">';
				thums='<div class="img box"><div class="thumb_slide" onload="sliderLoad($(this))"><div class="swiper-wrapper">';
				photos=photo.split(',');
				for(var i=0; i<photos.length; i++){
					thums+='<div class="swiper-slide"><img src="/festa/resources/upload/'+photos[i]+'" alt="" onload="squareTrim($(this), 290)"></div>';
				}
				thums+='</div><div class="swiper-pagination"></div></div></div>';
			//사진이 존재하지않을때 사진삭제
			}else{
				feedView='<div class="feed_viewer">';
				thums='';
			}
			
			if(data[0][index].profile.prophoto==null||data[0][index].profile.prophoto==''||data[0][index].profile.prophoto==undefined||data[0][index].profile.prophoto.isEmpty){
				feedprophototag='<img src="/festa/resources/images/thumb/no_profile.png" alt="'+data[0][index].profile.proname+'님의 프로필 썸네일" onload="squareTrim($(this), 55)">';
			}else{
				feedprophototag='<img src="/festa/resources/upload/'+data[0][index].profile.prophoto+'" alt="'+data[0][index].profile.proname+'님의 프로필 썸네일" onload="squareTrim($(this), 55)">';
			}
			
			$('.content_area').append(feedView
			+'<div class="tit box">'
			+'<dl class="feed_inform">'
			+'<dt>'
			+'<a href="/festa/user/?pronum='+data[0][index].pronum+'">'
			+'<input type="hidden" value="'+data[0][index].pronum+'">'
			+'<input type="hidden" value="'+num+'">'
			+grnum
			+'<span class="pf_picture">'+feedprophototag+'</span>'
			+'<span class="fd_name">'+author+'</span>'
			+grname
			+'</a>'
			+'</dt>'
			+'<dd>'
			+'<span class="fd_date">'+data[0][index].date1+'</span>'
			+'<b class="fd_liked">'+data[0][index].good+'</b>'
			+'</dd>'
			+'</dl>'
			+'<ul class="feed_options">'
			+likeBtn
			+reportBtn
			+editBtn
			+delBtn
			+'</ul>'
			+'</div>'
			+'<div class="text box">'
			+'<div class="scrBar">'
			+'<div class="feed_content">'
			+'<ul class="fd_hashtag">'
			+hashtag
			+'</ul>'
			+'<pre class="fd_content">'+content+'</pre>'
			+'</div>'
			+'<ul class="comment_list">'
			+cmmtList
			+'</ul>'
			+moreBtn
			+'</div>'
			+msgForm
			+'</div>'
			+'<input type="hidden" value="'+photo+'">'
			+thums
			+'</div>');
			scrBar();
			commSlider();
		});
	}else if(view=='news'){
		
	}else if(view=='group'){
		
	}else if(view=='user'){
		
	}else if(view=='admin/group'){
		$(data[0]).each(function(index){
			var hash1=data[0][index].httitle1;
			var hash2=data[0][index].httitle2;
			var hash3=data[0][index].httitle3;
			
			//해시태그 선언부
			if(hash1==''&&hash2==''&&hash3==''){
				hashtag='';
			}else if(hash1==''&&hash2==''&&hash3!=''){
				hashtag='<li><a href="">'+hash3+'</a></li>';
			}else if(hash1==''&&hash2!=''&&hash3!=''){
				hashtag='<li><a href="">'+hash3+'</a></li>'
				+'<li><a href="">'+hash2+'</a></li>';
			}else if(hash1==''&&hash2!=''&&hash3==''){
				hashtag='<li><a href="">'+hash2+'</a></li>';
			}else if(hash1!=''&&hash2==''&&hash3==''){
				hashtag='<li><a href="">'+hash1+'</a></li>';
			}else if(hash1!=''&&hash2==''&&hash3!=''){
				hashtag='<li><a href="">'+hash1+'</a></li>'
				+'<li><a href="">'+hash3+'</a></li>';
			}else if(hash1!=''&&hash2!=''&&hash3==''){
				hashtag='<li><a href="">'+hash1+'</a></li>'
				+'<li><a href="">'+hash2+'</a></li>';
			}else if(hash1!=''&hash2!=''&&hash3!=''){
				hashtag='<li><a href="">'+hash1+'</a></li>'
				+'<li><a href="">'+hash2+'</a></li>'
				+'<li><a href="">'+hash3+'</a></li>';
			}
			var moreBtn;
			var gpphoto;
			var gpphotos;
			var feedView;
			var thums;
			var cmmtCnt=0;
			var cmmtList='';
			var adminprophoto=data[0][index].profile.prophoto;
			var adminprophototag;
			
			if(data[0][index].gptotal>3){
				moreBtn='<button class="cmt_btn_more dt"><span class="snd_only">1</span>댓글 더 보기</button>';
			}else{
				moreBtn='';
			}
			//해당피드사진이 존재할때 사진등록
			if(data[0][index].gpphoto!=''){
				gpphoto=data[0][index].gpphoto;
				feedView='<div class="feed_viewer half">';
				thums='<div class="img box"><div class="thumb_slide" onload="sliderLoad($(this))"><div class="swiper-wrapper">';
				gpphotos=gpphoto.split(',');
				for(var i=0; i<gpphotos.length; i++){
					thums+='<div class="swiper-slide"><img src="/festa/resources/upload/'+gpphotos[i]+'" alt="" onload="squareTrim($(this), 290)"></div>';
				}
				thums+='</div><div class="swiper-pagination"></div></div></div>';
			//사진이 존재하지않을때 사진삭제
			}else{
				feedView='<div class="feed_viewer">';
				thums='';
			}
			
			//해당피드의 댓글출력
			$(data[1]).each(function(index1){
				var cmmtprophoto=data[1][index1].profile.prophoto;
				var cmmtprophototag;
				if(cmmtprophoto==null||cmmtprophoto==''||cmmtprophoto==undefined||cmmtprophoto.isEmpty){
					cmmtprophototag='<img src="/festa/resources/images/thumb/no_profile.png" alt="'+data[1][index1].profile.proname+'님의 프로필 썸네일" onload="squareTrim($(this), 30)">';
				}else{
					cmmtprophototag='<img src="/festa/resources/upload/'+data[1][index1].profile.prophoto+'" alt="'+data[1][index1].profile.proname+'님의 프로필 썸네일" onload="squareTrim($(this), 30)">';
				}
				//해당피드번호와 댓글의피드번호가 같을때 댓글리스트작성
				if(data[0][index].gpnum==data[1][index1].gpnum){
					
					cmmtList+='<li>'
						+'<a href="/festa/admin/user/detail?pronum='+data[1][index1].pronum+'" class="pf_picture">'
						+cmmtprophototag
						+'</a>'
						+'<p class="cmt_content">'
						+'<a href="/festa/admin/user/detail?pronum='+data[1][index1].pronum+'" class="cmt_name">'+data[1][index1].gcauthor+'</a>&nbsp;'
						+data[1][index1].gccontent
						+'<span class="cmt_date">'+data[1][index1].gcdate1+'</span>'
						+'<button class="btn_pop btn_delete btn_cmmt dt" data-layer="delete" data-value="'+data[1][index1].gcnum+'"><em class="snd_only">삭제하기</em></button>'
						+'</p></li>';
					cmmtCnt++;
				}
				if(cmmtCnt==3){
					return false;
				}
			});
			
			if(adminprophoto==null||adminprophoto==''||adminprophoto==undefined||adminprophoto.isEmpty){
				adminprophototag='<img src="/festa/resources/images/thumb/no_profile.png" alt="'+data[0][index].profile.proname+'님의 프로필 썸네일" onload="squareTrim($(this), 55)">';
			}else{
				adminprophototag='<img src="/festa/resources/upload/'+data[0][index].profile.prophoto+'" alt="'+data[0][index].profile.proname+'님의 프로필 썸네일" onload="squareTrim($(this), 55)">';
			}
			
			$('.content_area').append(feedView
			+'<div class="tit box">'
			+'<dl class="feed_inform">'
			+'<dt>'
			+'<a href="/festa/admin/user/detail?pronum='+data[0][index].pronum+'">'
			+'<input type="hidden" value="'+data[0][index].gpnum+'">'
			+'<span class="pf_picture">'+adminprophototag+'</span>'
			+'<span class="fd_name">'+data[0][index].gpauthor+'</span>'
			+'</a>'
			+'<a href="/festa/admin/group/detail?grnum='+data[0][index].grnum+'">'
			+'<span class="fd_group">'+data[0][index].group.grname+'</span>'
			+'</a>'
			+'</dt>'
			+'<dd>'
			+'<span class="fd_date">'+data[0][index].gpdate1+'</span>'
			+'<b class="fd_liked">'+data[0][index].gpgood+'</b>'
			+'</dd>'
			+'</dl>'
			+'<ul class="feed_options">'
			+'<li><button class="btn_pop btn_delete btn_feed dt" data-layer="delete" data-value="'+data[0][index].gpnum+'"><em class="snd_only">삭제하기</em></button></li>'
			+'</ul>'
			+'</div>'
			+'<div class="text box">'
			+'<div class="scrBar">'
			+'<div class="feed_content">'
			+'<ul class="fd_hashtag">'
			+hashtag
			+'</ul>'
			+'<pre class="fd_content">'+data[0][index].gpcontent+'</pre>'
			+'</div>'
			+'<ul class="comment_list">'
			+cmmtList
			+'</ul>'
			+moreBtn
			+'</div>'
			+'</div>'
			+thums
			+'</div>');
			scrBar();
			commSlider();
		});
	}else if(view=='admin/user'){
		$(data[0]).each(function(index){
			var hash1=data[0][index].httitle1;
			var hash2=data[0][index].httitle2;
			var hash3=data[0][index].httitle3;
			
			//해시태그 선언부
			if(hash1==''&&hash2==''&&hash3==''){
				hashtag='';
			}else if(hash1==''&&hash2==''&&hash3!=''){
				hashtag='<li><a href="">'+hash3+'</a></li>';
			}else if(hash1==''&&hash2!=''&&hash3!=''){
				hashtag='<li><a href="">'+hash3+'</a></li>'
				+'<li><a href="">'+hash2+'</a></li>';
			}else if(hash1==''&&hash2!=''&&hash3==''){
				hashtag='<li><a href="">'+hash2+'</a></li>';
			}else if(hash1!=''&&hash2==''&&hash3==''){
				hashtag='<li><a href="">'+hash1+'</a></li>';
			}else if(hash1!=''&&hash2==''&&hash3!=''){
				hashtag='<li><a href="">'+hash1+'</a></li>'
				+'<li><a href="">'+hash3+'</a></li>';
			}else if(hash1!=''&&hash2!=''&&hash3==''){
				hashtag='<li><a href="">'+hash1+'</a></li>'
				+'<li><a href="">'+hash2+'</a></li>';
			}else if(hash1!=''&hash2!=''&&hash3!=''){
				hashtag='<li><a href="">'+hash1+'</a></li>'
				+'<li><a href="">'+hash2+'</a></li>'
				+'<li><a href="">'+hash3+'</a></li>';
			}
			
			var moreBtn;
			var mpphoto;
			var mpphotos;
			var feedView;
			var thums;
			var cmmtCnt=0;
			var cmmtList='';
			var adminprophoto=data[0][index].profile.prophoto;
			var adminprophototag;
			
			if(data[0][index].mptotal>3){
				moreBtn='<button class="cmt_btn_more"><span class="snd_only">1</span>댓글 더 보기</button>';
			}else{
				moreBtn='';
			}
			
			//해당피드사진이 존재할때 사진등록
			if(data[0][index].mpphoto!=''){
				mpphoto=data[0][index].mpphoto;
				feedView='<div class="feed_viewer half">';
				thums='<div class="img box"><div class="thumb_slide"><div class="swiper-wrapper">';
				mpphotos=mpphoto.split(',');
				for(var i=0; i<mpphotos.length; i++){
					thums+='<div class="swiper-slide"><img src="/festa/resources/upload/'+mpphotos[i]+'" alt="" onload="squareTrim($(this), 290)"></div>';
				}
				thums+='</div><div class="swiper-pagination"></div></div></div>';
			//사진이 존재하지않을때 사진삭제
			}else{
				feedView='<div class="feed_viewer">';
				thums='';
			}
			
			//해당피드의 댓글출력
			$(data[1]).each(function(index1){
				var cmmtprophoto=data[1][index1].profile.prophoto;
				var cmmtprophototag;
				if(cmmtprophoto==null||cmmtprophoto==''||cmmtprophoto==undefined||cmmtprophoto.inEmpty){
					cmmtprophototag='<img src="/festa/resources/images/thumb/no_profile.png" alt="'+data[1][index1].profile.proname+'님의 프로필 썸네일" onload="squareTrim($(this), 30)">';
				}else{
					cmmtprophototag='<img src="/festa/resources/upload/'+data[1][index1].profile.prophoto+'" alt="'+data[1][index1].profile.proname+'님의 프로필 썸네일" onload="squareTrim($(this), 30)">';
				}
				//해당피드번호와 댓글의피드번호가 같을때 댓글리스트작성
				if(data[0][index].mpnum==data[1][index1].mpnum){
					
					cmmtList+='<li>'
						+'<a href="/festa/admin/user/detail?pronum='+data[1][index1].pronum+'" class="pf_picture">'
						+cmmtprophototag
						+'</a>'
						+'<p class="cmt_content">'
						+'<a href="/festa/admin/user/detail?pronum='+data[1][index1].pronum+'" class="cmt_name">'+data[1][index1].mcauthor+'</a>&nbsp;'
						+data[1][index1].mccontent
						+'<span class="cmt_date">'+data[1][index1].mcdate1+'</span>'
						+'<button class="btn_pop btn_delete btn_cmmt" data-layer="delete" data-value="'+data[1][index1].mcnum+'"><em class="snd_only">삭제하기</em></button>'
						+'</p></li>';
					cmmtCnt++;
				}
				if(cmmtCnt==3){
					return false;
				}
			});
			
			if(adminprophoto==null||adminprophoto==''||adminprophoto==undefined||adminprophoto.inEmpty){
				adminprophototag='<img src="/festa/resources/images/thumb/no_profile.png" alt="'+data[0][index].profile.proname+'님의 프로필 썸네일" onload="squareTrim($(this), 55)">';
			}else{
				adminprophototag='<img src="/festa/resources/upload/'+data[0][index].profile.prophoto+'" alt="'+data[0][index].profile.proname+'님의 프로필 썸네일" onload="squareTrim($(this), 55)">';
			}
			
			$('.content_area').append(feedView
			+'<div class="tit box">'
			+'<dl class="feed_inform">'
			+'<dt>'
			+'<a href="/festa/admin/user/detail?pronum='+data[0][index].pronum+'">'
			+'<input type="hidden" value="'+data[0][index].mpnum+'">'
			+'<span class="pf_picture">'
			+adminprophototag
			+'</span>'
			+'<span class="fd_name">'+data[0][index].mpauthor+'</span>'
			+'</a>'
			+'</dt>'
			+'<dd>'
			+'<span class="fd_date">'+data[0][index].mpdate1+'</span>'
			+'<b class="fd_liked">'+data[0][index].mpgood+'</b>'
			+'</dd>'
			+'</dl>'
			+'<ul class="feed_options">'
			+'<li><button class="btn_pop btn_delete btn_feed" data-layer="delete" data-value="'+data[0][index].mpnum+'"><em class="snd_only">삭제하기</em></button></li>'
			+'</ul>'
			+'</div>'
			+'<div class="text box">'
			+'<div class="scrBar">'
			+'<div class="feed_content">'
			+'<ul class="fd_hashtag">'
			+hashtag
			+'</ul>'
			+'<pre class="fd_content">'+data[0][index].mpcontent+'</pre>'
			+'</div>'
			+'<ul class="comment_list">'
			+cmmtList
			+'</ul>'
			+moreBtn
			+'</div>'
			+'</div>'
			+thums
			+'</div>');
			scrBar();
			commSlider();
		});
	}
}
/*
 * feed more end
 */

