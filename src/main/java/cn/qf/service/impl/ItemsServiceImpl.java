package cn.qf.service.impl;

import cn.qf.mapper.ItemsMapper;
import cn.qf.pojo.Items;
import cn.qf.service.ItemsService;
import cn.qf.util.PageUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ItemsServiceImpl implements ItemsService {
    @Autowired
    @SuppressWarnings("all")
    private ItemsMapper mapper;

    @Override
    public PageUtil select(Items i) {
        List L=mapper.select(i);
        int tc=mapper.selectTc(i);
        PageUtil pu = new PageUtil(i.getPage(),tc,L);
        return pu;
    }
    @Override
    public void add(Items i) {mapper.add(i);}
    @Override
    public void del(int[] ids) {mapper.del(ids);}
    @Override
    public void delById(int id) {
        mapper.delById(id);
    }
    @Override
    public void update(Items i) {
        mapper.update(i);
    }
}
