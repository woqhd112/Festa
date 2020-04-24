package com.fin.festa.util;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import com.fin.festa.model.entity.CampVo;
import com.fin.festa.model.entity.GroupNoticeVo;
import com.fin.festa.model.entity.GroupPostVo;
import com.fin.festa.model.entity.GroupVo;
import com.fin.festa.model.entity.MyPostVo;
import com.fin.festa.model.entity.ProfileVo;
import com.fin.festa.model.entity.ReportListVo;
import com.fin.festa.model.entity.UpdateWaitVo;

//파일업로드기능 인자값으로 MultipartFile, HttpServletRequest 필요 
//파일업로드 배열값으로 받아서 DB에 , 기준으로 넣어줄수있게 가공해줌
public class UploadPhoto {
   
   String path="festa0324\\festa0324\\src\\main\\webapp\\resources\\upload\\";
   
   //파일업로드 해주는메소드
   public String upload(MultipartFile[] files,HttpServletRequest req, MyPostVo mypost) {
      
      String agent = req.getHeader("User-Agent");
      String realPath=null;
      
      //현재 작업자의 프로젝트경로 알아내서 그경로의 resources안에 upload파일을 잡아줌
      if(agent.indexOf("Mac")!=-1) {
         realPath=req.getSession().getServletContext().getRealPath("/resources/upload");
      }else {
         realPath=req.getSession().getServletContext().getRealPath("\\resources\\upload");
      }
      
      //파일을 공백값 잡아주고 ,기준으로 더해주고 io작업
      int i=0;
      String photoName= "";
      for(MultipartFile multi : files) {
         if(multi.getOriginalFilename().isEmpty()) {
            i++;
            continue;
         }
         String filenames =multi.getOriginalFilename();
         String rename=System.currentTimeMillis()+"_"+filenames;
         
         if(i!=files.length-1) {
            photoName+=rename+",";
         }else {
            photoName+=rename;
         }
         File file = null;
         //현재 작업자의 프로젝트경로 알아내서 그경로의 resources안에 upload파일을 잡아줌
         if(agent.indexOf("Mac")!=-1) {
            file = new File(realPath+"/"+rename);
         }else {
            file = new File(realPath+"\\"+rename);
         }
         System.out.println(file.toString());
         try {
            multi.transferTo(file);
         } catch (IllegalStateException e) {
            e.printStackTrace();
         } catch (IOException e) {
            e.printStackTrace();
         }
         i++;
      }
      
      //마지막 ,값 처리
      String[] photo=null;
      //현재 작업자의 프로젝트경로 알아내서 그경로의 resources안에 upload파일을 잡아줌
      if(agent.indexOf("Mac")!=-1) {
         photo=photoName.split(",");
      }else {
         photo=photoName.split("\\,");
      }
      String photos="";
      for(int j=0; j<photo.length; j++) {
         if(j!=photo.length-1) {
            photos+=photo[j]+",";
         }else {
            photos+=photo[j];
         }
      }
      
      return photos;
   }
   // 프로필 이미지
   public String upload(MultipartFile[] files, HttpServletRequest req, ProfileVo profileVo) {
      String realPath = null;
      String agent = req.getHeader("User-Agent");

      // 현재 작업자의 프로젝트경로 알아내서 그경로의 resources안에 upload파일을 잡아줌
      if (agent.indexOf("Mac") != -1) {
         realPath = req.getSession().getServletContext().getRealPath("/resources/upload");
      } else {
         realPath = req.getSession().getServletContext().getRealPath("\\resources\\upload");
      }

      // 파일을 공백값 잡아주고 ,기준으로 더해주고 io작업
      int i = 0;
      String photoName = "";
      for (MultipartFile multi : files) {
         if (multi.getOriginalFilename().isEmpty()) {
            i++;
            continue;
         }
         String filenames = multi.getOriginalFilename();
         String rename = System.currentTimeMillis() + "_" + filenames;

         if (i != files.length - 1) {
            photoName += rename + ",";
         } else {
            photoName += rename;
         }
         File file = null;
         // 현재 작업자의 프로젝트경로 알아내서 그경로의 resources안에 upload파일을 잡아줌
         if (agent.indexOf("Mac") != -1) {
            file = new File(realPath + "/" + rename);
         } else {
            file = new File(realPath + "\\" + rename);
         }

         System.out.println(file.toString());
         try {
            multi.transferTo(file);
         } catch (IllegalStateException e) {
            e.printStackTrace();
         } catch (IOException e) {
            e.printStackTrace();
         }
         i++;
      }

      // 마지막 ,값 처리
      String[] photo = null;
      // 현재 작업자의 프로젝트경로 알아내서 그경로의 resources안에 upload파일을 잡아줌
      if (agent.indexOf("Mac") != -1) {
         photo = photoName.split(",");
      } else {
         photo = photoName.split("\\,");
      }

      String photos = "";
      for (int j = 0; j < photo.length; j++) {
         if (j != photo.length - 1) {
            photos += photo[j] + ",";
         } else {
            photos += photo[j];
         }
      }

      return photos;
   }

   // 캠핑장 관리 수정
   public String upload(MultipartFile[] files, HttpServletRequest req, CampVo campVo) {
      String realPath = null;
      String agent = req.getHeader("User-Agent");

      if (agent.indexOf("Mac") != -1) {
         realPath = req.getSession().getServletContext().getRealPath("/resources/upload");
      } else {
         realPath = req.getSession().getServletContext().getRealPath("\\resources\\upload");
      }

      // 파일을 공백값 잡아주고 ,기준으로 더해주고 io작업
      int i = 0;
      String photoName = "";
      for (MultipartFile multi : files) {
         if (multi.getOriginalFilename().isEmpty()) {
            i++;
            continue;
         }
         String filenames = multi.getOriginalFilename();
         String rename = System.currentTimeMillis() + "_" + filenames;

         if (i != files.length - 1) {
            photoName += rename + ",";
         } else {
            photoName += rename;
         }
         File file = null;
         // 현재 작업자의 프로젝트경로 알아내서 그경로의 resources안에 upload파일을 잡아줌
         if (agent.indexOf("Mac") != -1) {
            file = new File(realPath + "/" + rename);
         } else {
            file = new File(realPath + "\\" + rename);
         }

         System.out.println(file.toString());
         try {
            multi.transferTo(file);
         } catch (IllegalStateException e) {
            e.printStackTrace();
         } catch (IOException e) {
            e.printStackTrace();
         }
         i++;
         System.out.println("photoName : " + photoName);
      }

      // 마지막 ,값 처리
      String[] photo = null;
      // 현재 작업자의 프로젝트경로 알아내서 그경로의 resources안에 upload파일을 잡아줌
      if (agent.indexOf("Mac") != -1) {
         photo = photoName.split(",");
      } else {
         photo = photoName.split("\\,");
      }

      String photos = "";
      for (int j = 0; j < photo.length; j++) {
         if (j != photo.length - 1) {
            photos += photo[j] + ",";
         } else {
            photos += photo[j];
         }
      }

      return photos;
   }
   
   //파일업로드 해주는메소드
   public String upload(MultipartFile[] files,HttpServletRequest req, GroupPostVo groupPostVo) {
      
     String agent = req.getHeader("User-Agent");
      String realPath=null;
      
      //현재 작업자의 프로젝트경로 알아내서 그경로의 resources안에 upload파일을 잡아줌
      if(agent.indexOf("Mac")!=-1) {
         realPath=req.getSession().getServletContext().getRealPath("/resources/upload");
      }else {
         realPath=req.getSession().getServletContext().getRealPath("\\resources\\upload");
      }
      
      //파일을 공백값 잡아주고 ,기준으로 더해주고 io작업
      int i=0;
      String photoName= "";
      for(MultipartFile multi : files) {
         if(multi.getOriginalFilename().isEmpty()) {
            i++;
            continue;
         }
         String filenames =multi.getOriginalFilename();
         String rename=System.currentTimeMillis()+"_"+filenames;
         
         if(i!=files.length-1) {
            photoName+=rename+",";
         }else {
            photoName+=rename;
         }
         File file = null;
         //현재 작업자의 프로젝트경로 알아내서 그경로의 resources안에 upload파일을 잡아줌
         if(agent.indexOf("Mac")!=-1) {
            file = new File(realPath+"/"+rename);
         }else {
            file = new File(realPath+"\\"+rename);
         }
         System.out.println(file.toString());
         try {
            multi.transferTo(file);
         } catch (IllegalStateException e) {
            e.printStackTrace();
         } catch (IOException e) {
            e.printStackTrace();
         }
         i++;
      }
      
      //마지막 ,값 처리
      String[] photo=null;
      //현재 작업자의 프로젝트경로 알아내서 그경로의 resources안에 upload파일을 잡아줌
      if(agent.indexOf("Mac")!=-1) {
         photo=photoName.split(",");
      }else {
         photo=photoName.split("\\,");
      }
      String photos="";
      for(int j=0; j<photo.length; j++) {
         if(j!=photo.length-1) {
            photos+=photo[j]+",";
         }else {
            photos+=photo[j];
         }
      }
      
      return photos;
   }
   
   //파일업로드 해주는메소드
   public String upload(MultipartFile[] files,HttpServletRequest req, GroupNoticeVo groupNoticeVo) {
      
     String agent = req.getHeader("User-Agent");
      String realPath=null;
      
      //현재 작업자의 프로젝트경로 알아내서 그경로의 resources안에 upload파일을 잡아줌
      if(agent.indexOf("Mac")!=-1) {
         realPath=req.getSession().getServletContext().getRealPath("/resources/upload");
      }else {
         realPath=req.getSession().getServletContext().getRealPath("\\resources\\upload");
      }
      
      //파일을 공백값 잡아주고 ,기준으로 더해주고 io작업
      int i=0;
      String photoName= "";
      for(MultipartFile multi : files) {
         if(multi.getOriginalFilename().isEmpty()) {
            i++;
            continue;
         }
         String filenames =multi.getOriginalFilename();
         String rename=System.currentTimeMillis()+"_"+filenames;
         
         if(i!=files.length-1) {
            photoName+=rename+",";
         }else {
            photoName+=rename;
         }
         File file = null;
         //현재 작업자의 프로젝트경로 알아내서 그경로의 resources안에 upload파일을 잡아줌
         if(agent.indexOf("Mac")!=-1) {
            file = new File(realPath+"/"+rename);
         }else {
            file = new File(realPath+"\\"+rename);
         }
         System.out.println(file.toString());
         try {
            multi.transferTo(file);
         } catch (IllegalStateException e) {
            e.printStackTrace();
         } catch (IOException e) {
            e.printStackTrace();
         }
         i++;
      }
      
      //마지막 ,값 처리
      String[] photo=null;
      //현재 작업자의 프로젝트경로 알아내서 그경로의 resources안에 upload파일을 잡아줌
      if(agent.indexOf("Mac")!=-1) {
         photo=photoName.split(",");
      }else {
         photo=photoName.split("\\,");
      }
      String photos="";
      for(int j=0; j<photo.length; j++) {
         if(j!=photo.length-1) {
            photos+=photo[j]+",";
         }else {
            photos+=photo[j];
         }
      }
      
      return photos;
   }
   
   //파일업로드 해주는메소드
   public String upload(MultipartFile[] files,HttpServletRequest req, ReportListVo reportListVo) {
      
     String agent = req.getHeader("User-Agent");
      String realPath=null;
      
      //현재 작업자의 프로젝트경로 알아내서 그경로의 resources안에 upload파일을 잡아줌
      if(agent.indexOf("Mac")!=-1) {
         realPath=req.getSession().getServletContext().getRealPath("/resources/upload");
      }else {
         realPath=req.getSession().getServletContext().getRealPath("\\resources\\upload");
      }
      
      //파일을 공백값 잡아주고 ,기준으로 더해주고 io작업
      int i=0;
      String photoName= "";
      for(MultipartFile multi : files) {
         if(multi.getOriginalFilename().isEmpty()) {
            i++;
            continue;
         }
         String filenames =multi.getOriginalFilename();
         String rename=System.currentTimeMillis()+"_"+filenames;
         
         if(i!=files.length-1) {
            photoName+=rename+",";
         }else {
            photoName+=rename;
         }
         File file = null;
         //현재 작업자의 프로젝트경로 알아내서 그경로의 resources안에 upload파일을 잡아줌
         if(agent.indexOf("Mac")!=-1) {
            file = new File(realPath+"/"+rename);
         }else {
            file = new File(realPath+"\\"+rename);
         }
         System.out.println(file.toString());
         try {
            multi.transferTo(file);
         } catch (IllegalStateException e) {
            e.printStackTrace();
         } catch (IOException e) {
            e.printStackTrace();
         }
         i++;
      }
      
      //마지막 ,값 처리
      String[] photo=null;
      //현재 작업자의 프로젝트경로 알아내서 그경로의 resources안에 upload파일을 잡아줌
      if(agent.indexOf("Mac")!=-1) {
         photo=photoName.split(",");
      }else {
         photo=photoName.split("\\,");
      }
      String photos="";
      for(int j=0; j<photo.length; j++) {
         if(j!=photo.length-1) {
            photos+=photo[j]+",";
         }else {
            photos+=photo[j];
         }
      }
      
      return photos;
   }

   
   //파일업로드 해주는메소드
   public String upload(MultipartFile[] files,HttpServletRequest req, GroupVo groupVo) {
      
     String agent = req.getHeader("User-Agent");
      String realPath=null;
      
      //현재 작업자의 프로젝트경로 알아내서 그경로의 resources안에 upload파일을 잡아줌
      if(agent.indexOf("Mac")!=-1) {
         realPath=req.getSession().getServletContext().getRealPath("/resources/upload");
      }else {
         realPath=req.getSession().getServletContext().getRealPath("\\resources\\upload");
      }
      
      //파일을 공백값 잡아주고 ,기준으로 더해주고 io작업
      int i=0;
      String photoName= "";
      for(MultipartFile multi : files) {
         if(multi.getOriginalFilename().isEmpty()) {
            i++;
            continue;
         }
         String filenames =multi.getOriginalFilename();
         String rename=System.currentTimeMillis()+"_"+filenames;
         
         if(i!=files.length-1) {
            photoName+=rename+",";
         }else {
            photoName+=rename;
         }
         File file = null;
         //현재 작업자의 프로젝트경로 알아내서 그경로의 resources안에 upload파일을 잡아줌
         if(agent.indexOf("Mac")!=-1) {
            file = new File(realPath+"/"+rename);
         }else {
            file = new File(realPath+"\\"+rename);
         }
         System.out.println(file.toString());
         try {
            multi.transferTo(file);
         } catch (IllegalStateException e) {
            e.printStackTrace();
         } catch (IOException e) {
            e.printStackTrace();
         }
         i++;
      }
      
      //마지막 ,값 처리
      String[] photo=null;
      //현재 작업자의 프로젝트경로 알아내서 그경로의 resources안에 upload파일을 잡아줌
      if(agent.indexOf("Mac")!=-1) {
         photo=photoName.split(",");
      }else {
         photo=photoName.split("\\,");
      }
      String photos="";
      for(int j=0; j<photo.length; j++) {
         if(j!=photo.length-1) {
            photos+=photo[j]+",";
         }else {
            photos+=photo[j];
         }
      }
      
      return photos;
   }
   
 //사업자 신청
   public String upload(MultipartFile[] files, HttpServletRequest req, UpdateWaitVo updateWaitVo) {
	   
	     String agent = req.getHeader("User-Agent");
	      String realPath=null;
	      
	      //현재 작업자의 프로젝트경로 알아내서 그경로의 resources안에 upload파일을 잡아줌
	      if(agent.indexOf("Mac")!=-1) {
	         realPath=req.getSession().getServletContext().getRealPath("/resources/upload");
	      }else {
	         realPath=req.getSession().getServletContext().getRealPath("\\resources\\upload");
	      }
	      
	      //파일을 공백값 잡아주고 ,기준으로 더해주고 io작업
	      int i=0;
	      String photoName= "";
	      for(MultipartFile multi : files) {
	         if(multi.getOriginalFilename().isEmpty()) {
	            i++;
	            continue;
	         }
	         String filenames =multi.getOriginalFilename();
	         String rename=System.currentTimeMillis()+"_"+filenames;
	         
	         if(i!=files.length-1) {
	            photoName+=rename+",";
	         }else {
	            photoName+=rename;
	         }
	         File file = null;
	         //현재 작업자의 프로젝트경로 알아내서 그경로의 resources안에 upload파일을 잡아줌
	         if(agent.indexOf("Mac")!=-1) {
	            file = new File(realPath+"/"+rename);
	         }else {
	            file = new File(realPath+"\\"+rename);
	         }
	         System.out.println(file.toString());
	         try {
	            multi.transferTo(file);
	         } catch (IllegalStateException e) {
	            e.printStackTrace();
	         } catch (IOException e) {
	            e.printStackTrace();
	         }
	         i++;
	      }
	      
	      //마지막 ,값 처리
	      String[] photo=null;
	      //현재 작업자의 프로젝트경로 알아내서 그경로의 resources안에 upload파일을 잡아줌
	      if(agent.indexOf("Mac")!=-1) {
	         photo=photoName.split(",");
	      }else {
	         photo=photoName.split("\\,");
	      }
	      String photos="";
	      for(int j=0; j<photo.length; j++) {
	         if(j!=photo.length-1) {
	            photos+=photo[j]+",";
	         }else {
	            photos+=photo[j];
	         }
	      }
	      
	      return photos;
   }
   
}