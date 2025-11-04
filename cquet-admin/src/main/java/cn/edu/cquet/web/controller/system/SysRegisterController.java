package cn.edu.cquet.web.controller.system;

import cn.edu.cquet.common.core.domain.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import cn.edu.cquet.common.core.controller.BaseController;
import cn.edu.cquet.common.core.domain.model.RegisterBody;
import cn.edu.cquet.common.utils.StringUtils;
import cn.edu.cquet.framework.web.service.SysRegisterService;
import cn.edu.cquet.system.service.ISysConfigService;

/**
 * 注册验证
 * 
 */
@RestController
public class SysRegisterController extends BaseController
{
    @Autowired
    private SysRegisterService registerService;

    @Autowired
    private ISysConfigService configService;

    @PostMapping("/register")
    public Result register(@RequestBody RegisterBody user)
    {
        if (!("true".equals(configService.selectConfigByKey("sys.account.registerUser"))))
        {
            return error("当前系统没有开启注册功能！");
        }
        String msg = registerService.register(user);
        return StringUtils.isEmpty(msg) ? success() : error(msg);
    }
}
