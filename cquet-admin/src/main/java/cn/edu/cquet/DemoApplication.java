package cn.edu.cquet;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.SpringBootVersion;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.core.SpringVersion;

/**
 * 启动程序
 *
 */
@SpringBootApplication(exclude = { DataSourceAutoConfiguration.class })
public class DemoApplication{
    public static void main(String[] args)
    {
        SpringApplication.run(DemoApplication.class, args);
        String sVersion = SpringVersion.getVersion();
        System.out.println("Spring 版本号：" + sVersion);
        String bVersion = SpringBootVersion.getVersion();
        System.out.println("SpringBoot 版本号：" + bVersion);
    }
}
