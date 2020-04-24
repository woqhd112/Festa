package com.fin.festa.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.fin.festa.model.entity.ChatVo;

public class ChatDao {

	private Connection conn;
	
	public ChatDao() {
		try {
			String url="jdbc:mysql://localhost:3306/festa";
			String id="scott";
			String password="Aa2381016";
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(url, id, password);
		} catch (Exception e){
			e.printStackTrace();
		}
	}
	
	public ArrayList<ChatVo> getChatList(String nowTime) throws SQLException{
		ArrayList<ChatVo> chatList=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="SELECT * FROM chat WHERE chatTime > ? ORDER BY chatTime";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, nowTime);
			rs=pstmt.executeQuery();
			chatList=new ArrayList<ChatVo>();
			while(rs.next()) {
				ChatVo chatVo=new ChatVo();
				chatVo.setChatName(rs.getString("chatName"));
				chatVo.setChatContent(rs.getString("chatContent"));
				chatVo.setChatTime(rs.getDate("chatTime"));
				chatList.add(chatVo);
			}
		} finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return chatList;
	}
	
	public int submit(String chatName, String chatContent) throws SQLException {
		PreparedStatement pstmt=null;
		String sql="INSERT INTO CHAT VALUES (?, ?, now())";
		String content=chatContent.trim();
		if(content==null) {
			return 0;
		}
		int result=0;
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, chatName);
			pstmt.setString(2, chatContent);
			result=pstmt.executeUpdate();
		} finally {
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return result;
	}
}
