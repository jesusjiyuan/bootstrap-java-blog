package com.rest.domain;

import lombok.Data;

import java.util.Date;

/**
 * Created by bruce.ge on 2016/11/6.
 */
@Data
public class Content {
    private Integer id;

    private String title;

    private String source_content;

    private String html_content;

    private Date updatetime;

    private Date addtime;

    private String index_content;


    //    the use who wrote the article
    private Integer userId;

    //the article status.
    private Integer status;

}
