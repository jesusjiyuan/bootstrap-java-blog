<html>
<head>
<#include "head_header.ftl">
    <link href="/static/css/markdown.css" rel="stylesheet">
    <link href="/static/css/comment.css" rel="stylesheet">
</head>
<body>
<#include "header.ftl">
<div class="container">
    <div class="col-sm-8 blog-main">
        <div id="blogdata">
        <#--adddata to this position-->
            <div class="blog-post">
                <h2 class="blog-post-title">${vo.title}</h2>
                <p class="blog-post-meta">${vo.addtime}</p>
            ${vo.content}
            </div>
        </div>
        <div>
        <#if comment??>

            <form id="commentform" class="form-horizontal " action="/comment/${vo.id}">
                <div class="form-group">
                    <label for="exampleInputEmail1"><@spring.message "Comment"/>:</label>
                    <input type="text" name="name" class="form-control" style="width:30%; margin-bottom: 10px;"
                           placeholder="<@spring.message "commentname"/>"
                           required="true"/>
                    <textarea name="content" class="form-control" rows="4" required="true"
                              placeholder="<@spring.message "commentContent"/>"></textarea>
                    <p class="text-center text-danger" id="comment-warn" style="display: none"></p>
                    <button type="submit" class="btn btn-primary"
                            style="margin-top: 10px;"><@spring.message "addCommentButton"/></button>
                </div>
            </form>

            <div id="firstcomment"></div>
            <#list commentVos as commentVo>
                <div class="row">
                    <div class="col-sm-1">
                        <div class="thumbnail">
                            <img class="img-responsive user-photo"
                                 src="/static/img/anonymous.gif">
                        </div><!-- /thumbnail -->
                    </div><!-- /col-sm-1 -->

                    <div class="col-sm-7">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <strong>${commentVo.name}</strong> <span
                                    class="text-muted">${commentVo.ago}</span>
                                <img src="/img/reply.png" class="reply " tabindex="${commentVo?index}"></img>
                            </div>
                            <div class="panel-body">
                            ${commentVo.comment}
                            </div><!-- /panel-body -->
                            <div>
                                <form class="reply-form" id="form_${commentVo?index}" style="display: none;"
                                      action="/reply">
                                    <input type='hidden' name='replyCommentId' value="${commentVo.id}">
                                    <input type='hidden' name='articleId' value="${vo.id}">
                                    <input type='text' class='form-control' style="width:30%;margin-bottom: 10px;"
                                           name='name'
                                           placeholder='<@spring.message "commentname"/>' required="true">
                                    <input type='text' class='form-control' name='content'
                                           placeholder='<@spring.message "commentContent"/>'
                                           required="true">
                                    <button type='submit'
                                            class="btn btn-primary "><@spring.message "commentReply"/></button>
                                </form>
                            </div>
                        </div><!-- /panel panel-default -->
                    </div><!-- /col-sm-5 -->

                </div>

            <#--here is hidden form when press with reply will display-->
                <input type="hidden" id="articleId" value="${vo.id}"/>
            </#list>
        </#if>
        </div>
    </div>

</div>
<#include "footer.ftl">
<script src="//cdn.bootcss.com/jquery/3.1.1/jquery.min.js"></script>
<script src="//cdn.bootcss.com/jquery-validate/1.15.1/jquery.validate.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $(".reply").click(function (e) {
            $(".reply").show();
            $(".reply-form").hide();
            var s = $(this).attr("tabindex");
            $(this).hide();
//            $("#form_"+s+" input[name=content]").val("nimei");
            $("#form_" + s).show();
        })

        $("#commentform").submit(function (e) {
            var articleId = $("#articleId").val();
            e.preventDefault();
            $.ajax({
                type: 'POST',
                data: $("#commentform").serialize(),
                url: '/comment/' + articleId,
                success: function (response) {
                    if (response.code != 200) {
                        console.log(response.msg);
                        $("#comment-warn").html(response.msg);
                        $("#comment-warn").show();
//                        $("#register-warn").html(response.msg);
//                        $("#register-warn").show();
                    } else {
                        window.location.href = "/getArticle/" + articleId;
                    }
                }
            })
        })


        $(".reply-form").submit(function (e) {
            var articleId = $("#articleId").val();
            e.preventDefault();
            $.ajax({
                type: 'POST',
                data: $(this).serialize(),
                url: '/reply',
                success: function (response) {
                    if (response.code != 200) {
                        console.log(response.msg);
                        $("#comment-warn").html(response.msg);
                        $("#comment-warn").show();
//                        $("#register-warn").html(response.msg);
//                        $("#register-warn").show();
                    } else {
                        window.location.href = "/getArticle/" + articleId;
                    }
                }
            })
        })

    })
</script>
</body>
</html>