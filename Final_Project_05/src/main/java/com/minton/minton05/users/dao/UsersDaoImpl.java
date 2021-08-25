package com.minton.minton05.users.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.minton.minton05.users.dto.UsersDto;



@Repository
public class UsersDaoImpl implements UsersDao {
   @Autowired
   private SqlSession session;
   
   @Override
   public boolean isExist(String inputId) {
      String id=session.selectOne("users.isExist", inputId);
      if(id==null) {
         return false;
      }else {
         return true;   
         }
      }

   @Override
   public void insert(UsersDto dto) {
      session.insert("users.insert", dto);      
   }

   @Override
   public UsersDto getData(String id) {
      return session.selectOne("users.getData", id);
   }

   @Override
   public void updatePwd(UsersDto dto) {
      session.update("users.pwdUpdate", dto);
      
   }

   @Override
   public void update(UsersDto dto) {
      session.update("users.update", dto);
      
   }

   @Override
   public void delete(String id) {
      session.delete("users.delete", id);
      
   }
   
}
