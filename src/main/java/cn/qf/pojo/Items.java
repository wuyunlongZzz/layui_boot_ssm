package cn.qf.pojo;

public class Items {

    private Integer id;
    private Integer status;
    private String name;
    private Float price;
    private String pic;
    private String createtime;
    private String detail;
    private Integer page=1;
    private Integer limit=4;
    private Integer sp;

    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }
    public Integer getStatus() {
        return status;
    }
    public void setStatus(Integer status) {
        this.status = status;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }
    public Float getPrice() {
        return price;
    }
    public void setPrice(Float price) {
        this.price = price;
    }
    public String getPic() {
        return pic;
    }
    public void setPic(String pic) {
        this.pic = pic == null ? null : pic.trim();
    }
    public String getCreatetime() {
        return createtime;
    }
    public void setCreatetime(String createtime) {
        this.createtime = createtime;
    }
    public String getDetail() {
        return detail;
    }
    public void setDetail(String detail) {
        this.detail = detail == null ? null : detail.trim();
    }
    public Integer getPage() {
        return page;
    }
    public void setPage(Integer page) {
        this.page = page;
    }
    public Integer getLimit() {
        return limit;
    }
    public void setLimit(Integer limit) {
        this.limit = limit;
    }
    public Integer getSp() {
        return (page-1)*limit;
    }
    public void setSp(Integer sp) {
        this.sp = sp;
    }
}