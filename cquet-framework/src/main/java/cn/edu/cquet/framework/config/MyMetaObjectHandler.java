package cn.edu.cquet.framework.config;

import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import cn.edu.cquet.common.utils.SecurityUtils;
import cn.edu.cquet.common.utils.StringUtils;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.reflection.MetaObject;
import org.springframework.stereotype.Component;

import java.sql.Timestamp;
import java.util.Date;
import java.util.Objects;
import java.util.function.Supplier;

/**
 * MybatisPlus 自动填充功能
 * MybatisPlus 起始版本 3.3.0(推荐使用)
 *
 *
 */

@Slf4j
@Component
public class MyMetaObjectHandler implements MetaObjectHandler {

    @Override
    public void insertFill(MetaObject metaObject) {
        log.info("自动填充-insert");
        // 起始版本 3.3.0(推荐使用)
        this.strictInsertFill(metaObject, "createTime", Date.class, new Timestamp(System.currentTimeMillis()));
        this.strictInsertFill(metaObject, "operTime", Date.class, new Timestamp(System.currentTimeMillis()));
        this.strictInsertFill(metaObject, "loginTime", Date.class, new Timestamp(System.currentTimeMillis()));
        if (StringUtils.isNotNull(SecurityUtils.getAuthentication()) && !"anonymousUser".equals(SecurityUtils.getAuthentication().getPrincipal())) {
            this.strictInsertFill(metaObject, "createBy", String.class, SecurityUtils.getUsername());
        }
        // 默认设置删除状态0
        this.strictInsertFill(metaObject,"delFlag",  String.class, "0");
    }

    @Override
    public void updateFill(MetaObject metaObject) {
        log.info("自动填充-update");
        // 起始版本 3.3.0(推荐)
        this.strictUpdateFill(metaObject, "updateTime", Date.class, new Timestamp(System.currentTimeMillis()));
        boolean notNull = StringUtils.isNotNull(SecurityUtils.getAuthentication());
        if (notNull) {
            Object principal = SecurityUtils.getAuthentication().getPrincipal();
            if (!"anonymousUser".equals(principal)) {

                this.strictUpdateFill(metaObject, "updateBy", String.class, SecurityUtils.getUsername());
            }
        }
    }

    /**
     * 严格模式填充策略,默认有值不覆盖,如果提供的值为null也不填充
     * modify-author: fsd
     * modify-issue: 重写strictFillStrategy方法，解决null值不自动填充问题
     *
     * @param metaObject metaObject meta object parameter
     * @param fieldName  java bean property name
     * @param fieldVal   java bean property value of Supplier
     * @return this
     * @since 3.3.0
     */
    @Override
    public MetaObjectHandler strictFillStrategy(MetaObject metaObject, String fieldName, Supplier<?> fieldVal) {
        Object obj = fieldVal.get();
        if (Objects.nonNull(obj)) {
            metaObject.setValue(fieldName, obj);
        }
        return this;
    }

}

