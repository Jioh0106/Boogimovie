<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.BufferedReader, java.io.InputStreamReader, java.net.HttpURLConnection, java.net.URL, org.json.simple.JSONArray, org.json.simple.JSONObject, org.json.simple.parser.JSONParser" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>boogi movie</title>
    <style>
        body {
            text-align: center;
            font-family: Arial, sans-serif;
            background-color: black;
        }
        .trailer-container {
            margin: 10px auto;
            width: 80%;
        }
        iframe {
            width: 100%;
            height: 700px;
            border-radius: 10px;
            border: none;
        }
        
        article {
        	background-color: black;
        	padding-top: 30px;
        	padding-bottom: 50px;
        }
        
        #player{
        	height: 600px;
        	background-color: black;
        }
        
    </style>
</head>
<body>
    <header>
        <jsp:include page="../inc/top.jsp"></jsp:include>
    </header>
    
    <article>
		<div class="trailer-container">
		    <div id="player"></div> <!-- YouTube IFrame API를 위한 div -->
		</div>
    </article>

    <footer>
        <jsp:include page="../inc/footer.jsp"></jsp:include>
    </footer>
    
    <!-- YouTube IFrame API 추가 -->
    <script src="https://www.youtube.com/iframe_api"></script>

    <script type="text/javascript">
	    let player;
	    let nextTrailerKey = null;
	
	    function onYouTubeIframeAPIReady() {
	        fetchTrailer(); // YouTube API가 준비되면 예고편 요청 시작
	    }
	
	    async function fetchTrailer() {
	        try {
	            let response = await fetch("getTrailer");
	            let data = await response.json();
	            console.log("🎬 API 응답:", data);
	
	            if (data.trailerKey) {
	                nextTrailerKey = data.trailerKey;
	
	                if (!player) {
	                    // 첫 번째 예고편 로드
	                    loadPlayer(nextTrailerKey);
	                }
	            } else {
	                console.warn("⚠️ 트레일러 없음. 다시 시도...");
	                setTimeout(fetchTrailer, 1000);
	            }
	        } catch (error) {
	            console.error("❌ Error fetching trailer:", error);
	        }
	    }
	
	    function loadPlayer(videoId) {
	        if (player) {
	            player.destroy();
	        }
	
	        player = new YT.Player('player', {
	            videoId: videoId,
	            playerVars: {
	                autoplay: 1,
	                mute: 1,
	                playsinline: 1
	            },
	            events: {
	                'onReady': function(event) {
	                    event.target.playVideo();
	                    fetchTrailer(); // 다음 예고편 미리 가져오기
	                },
	                'onStateChange': function(event) {
	                    if (event.data === YT.PlayerState.ENDED) { 
	                        console.log("🎞 예고편 종료, 다음 예고편 로드...");
	                        if (nextTrailerKey) {
	                            loadPlayer(nextTrailerKey); // 즉시 새로운 예고편 재생
	                            nextTrailerKey = null; // 새로운 예고편 가져오도록 설정
	                            fetchTrailer(); // 다음 예고편 다시 요청
	                        }
	                    }
	                }
	            }
	        });
	    }

    </script>
</body>
</html>
