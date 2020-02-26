
import com.alibaba.fastjson.JSON;
import org.junit.Before;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.io.*;
import java.util.Map;

import static org.springframework.security.test.web.servlet.setup.SecurityMockMvcConfigurers.springSecurity;

/**
 * controller测试初始化
 *
 * @author XuZhuohao
 * @date 2018/12/29
 */
public class BaseController extends WebAdminApplicationTest {
    /**
     * spring web 应用程序上下文
     */
    @Autowired
    private WebApplicationContext wac;
    /**
     * 模拟 mvc 请求对象,适用 security 校验
     */
    private MockMvc securityMockMvc;
    /**
     * 模拟 mvc 请求对象
     */
    private MockMvc mockMvc;

    /**
     * 初始化 MockMvc 对象
     * mockMvc 直接构建，
     * securityMockMvc 通过 security 配置 spring-security-test 进行构建
     */
    @Before
    public void setup() {
        // 没有安全配置的
        mockMvc = MockMvcBuilders.webAppContextSetup(wac).build();
        // security 配置
        securityMockMvc = MockMvcBuilders
                .webAppContextSetup(wac)
                .apply(springSecurity())
                .build();
    }

    /**
     * 发票post请求， json参数
     * @param object 请求参数
     * @param url   请求地址
     * @throws Exception exception
     */
    void doPostWhenSuccess(Object object, String url) throws Exception {
        String result = mockMvc.perform(MockMvcRequestBuilders.post(url)
                .contentType(MediaType.APPLICATION_JSON_UTF8)
                .content(JSON.toJSONBytes(object)))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andReturn().getResponse().getContentAsString();
        System.out.println(result);
    }

    /**
     * 发起 get 请求
     * @param inMap 请求参数
     * @param url   请求地址
     * @throws Exception exception
     */
    void doGetWhenSuccess(Map<String, String> inMap, String url) throws Exception {
        MockHttpServletRequestBuilder builder = MockMvcRequestBuilders.get(url);
        inMap.forEach(builder::param);
        String result = mockMvc.perform(builder
                .contentType(MediaType.APPLICATION_JSON_UTF8))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(MockMvcResultMatchers.jsonPath("$.length()").value(3))
                .andReturn().getResponse().getContentAsString();
        System.out.println(result);
    }

    /**
     * 模拟用户登录后的请求，需要添加注解 @WithUserDetails(value = "admin", userDetailsServiceBeanName = "userDetailsServiceImpl")
     * value 为用户请求值，当前项目为用户longin_name 需要在用户表中存在
     *
     * @param object 请求参数
     * @param url   请求地址
     * @throws Exception exception
     */
    void doPostWhenSuccessWithLogin(Object object, String url) throws Exception {
        String result = securityMockMvc.perform(MockMvcRequestBuilders.post(url)
                .contentType(MediaType.APPLICATION_JSON_UTF8)
                .content(JSON.toJSONBytes(object)))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andReturn().getResponse().getContentAsString();
        System.out.println(result);
    }

    /**
     * 发起 Get 请求，并下载
     * @param inMap Get参数
     * @param url 请求地址
     * @param path 下载根目录
     * @throws Exception e
     */
    void doGetWhenSuccessAndDownload(Map<String, String> inMap, String url, String path) throws Exception {
        MockHttpServletRequestBuilder builder = MockMvcRequestBuilders.get(url);
        inMap.forEach(builder::param);
        final MockHttpServletResponse response = mockMvc.perform(builder
                .contentType(MediaType.APPLICATION_JSON_UTF8))
                .andExpect(MockMvcResultMatchers.status().isOk())
//                .andExpect(MockMvcResultMatchers.jsonPath("$.length()").value(3))
                .andReturn().getResponse();
        final String filename = response.getHeader("Content-disposition").split("filename=")[1];
        File downloadFile = new File(path + File.separator + filename);
        FileUtil.mkdirs(downloadFile);
        try (OutputStream os = new FileOutputStream(downloadFile)) {
            os.write(response.getContentAsByteArray());
        }
        System.out.println("下载文件地址:" + downloadFile.getAbsolutePath());
    }

    /**
     * 文件上传测试
     * 需要添加注解 @WithUserDetails(value = "admin", userDetailsServiceBeanName = "userDetailsServiceImpl")
     * @param paramFileName 文件传参名字
     * @param file 文件
     * @param url url
     */
    void doPostUploadWhenSuccessWithLogin(String paramFileName, File file, String url) throws Exception{
        try(ByteArrayOutputStream bao = new ByteArrayOutputStream();
            InputStream is = new FileInputStream(file)){
            byte[] bytes = new byte[is.available()];
            is.read(bytes);
            bao.write(bytes);
            final String result = securityMockMvc.perform(MockMvcRequestBuilders.fileUpload(url)
                    .file(new MockMultipartFile(paramFileName, file.getName(), ",multipart/form-data", bao.toByteArray())))
                    .andExpect(MockMvcResultMatchers.status().isOk())
                    .andReturn().getResponse().getContentAsString();
            System.out.println(result);
        }


    }
}
