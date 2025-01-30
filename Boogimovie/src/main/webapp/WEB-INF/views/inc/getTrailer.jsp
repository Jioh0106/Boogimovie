<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.BufferedReader, java.io.InputStreamReader, java.net.HttpURLConnection, java.net.URL, org.json.simple.JSONArray, org.json.simple.JSONObject, org.json.simple.parser.JSONParser" %>
<%@ page import="java.util.Random" %>

<%
    String TMDB_API_KEY = "0920b5a7f2c9d13e87b9a629c8bdaeba";
    String TMDB_BASE_URL = "https://api.themoviedb.org/3";
    String language = "ko-KR";
    JSONObject jsonResponse = new JSONObject();

    try {
        // 1️⃣ 최신 개봉 영화 리스트 한 번만 가져오기
        URL url = new URL(TMDB_BASE_URL + "/movie/now_playing?api_key=" + TMDB_API_KEY + "&language=" + language + "&page=1");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Accept", "application/json");

        if (conn.getResponseCode() != 200) {
            jsonResponse.put("error", "Failed to fetch movies.");
            out.print(jsonResponse.toJSONString());
            return;
        }

        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
        String moviesJson = br.readLine();
        conn.disconnect();

        JSONParser parser = new JSONParser();
        JSONObject responseObject = (JSONObject) parser.parse(moviesJson);
        JSONArray moviesArray = (JSONArray) responseObject.get("results");

        if (moviesArray.isEmpty()) {
            jsonResponse.put("error", "No movies found.");
            out.print(jsonResponse.toJSONString());
            return;
        }

        // 2️⃣ 여러 개의 영화를 랜덤하게 시도하여 예고편이 있는 영화 찾기
        Random random = new Random();
        String trailerKey = "";
        int attempts = 0;

        while (attempts < 5 && trailerKey.isEmpty()) {
            int randomIndex = random.nextInt(moviesArray.size());
            JSONObject movie = (JSONObject) moviesArray.get(randomIndex);
            String movieId = String.valueOf(movie.get("id"));

            // 3️⃣ 예고편 정보를 가져오기
            URL trailerUrl = new URL(TMDB_BASE_URL + "/movie/" + movieId + "/videos?api_key=" + TMDB_API_KEY + "&language=" + language);
            HttpURLConnection trailerConn = (HttpURLConnection) trailerUrl.openConnection();
            trailerConn.setRequestMethod("GET");
            trailerConn.setRequestProperty("Accept", "application/json");

            if (trailerConn.getResponseCode() != 200) {
                trailerConn.disconnect();
                attempts++;
                continue;
            }

            BufferedReader trailerBr = new BufferedReader(new InputStreamReader(trailerConn.getInputStream(), "UTF-8"));
            String trailerJsonString = trailerBr.readLine();
            trailerConn.disconnect();

            JSONObject trailerResponse = (JSONObject) parser.parse(trailerJsonString);
            JSONArray videosArray = (JSONArray) trailerResponse.get("results");

            for (Object obj : videosArray) {
                JSONObject video = (JSONObject) obj;
                String type = (String) video.get("type");
                String site = (String) video.get("site");

                if ("Trailer".equalsIgnoreCase(type) && "YouTube".equalsIgnoreCase(site)) {
                    trailerKey = (String) video.get("key");
                    break;
                }
            }
            attempts++;
        }

        if (!trailerKey.isEmpty()) {
            jsonResponse.put("trailerKey", trailerKey);
        } else {
            jsonResponse.put("error", "No valid trailer found.");
        }
    } catch (Exception e) {
        jsonResponse.put("error", "Exception occurred: " + e.getMessage());
        e.printStackTrace();
    }

    out.print(jsonResponse.toJSONString());
%>
