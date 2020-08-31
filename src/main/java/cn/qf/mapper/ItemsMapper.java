package cn.qf.mapper;

import cn.qf.pojo.Items;

import java.util.List;

public interface ItemsMapper {
    List select(Items i);
    int selectTc(Items i);
    void add(Items i);
    void del(int[] ids);
    void delById(int id);
    void update(Items i);
}