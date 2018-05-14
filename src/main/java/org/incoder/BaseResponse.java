/*
 * Copyright (C) 2018 Jerry xu Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.incoder;

import java.util.HashMap;
import java.util.Map;

/**
 * 返回数据包装.
 *
 * @author : Jerry xu
 * @version : 1.0
 * @since : 5/10/2018 12:36 AM
 */
public class BaseResponse {

    // 状态码：0:处理失败 1:处理成功
    private int code;
    // 返回提示信息
    private String message;
    // 返回数据
    private Map<String, Object> data = new HashMap<String, Object>();

    public static BaseResponse success() {
        BaseResponse response = new BaseResponse();
        response.setCode(1);
        response.setMessage("处理成功");
        return response;
    }

    public static BaseResponse fail() {
        BaseResponse response = new BaseResponse();
        response.setCode(0);
        response.setMessage("处理失败");
        return response;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Map<String, Object> getData() {
        return data;
    }

    public void setData(Map<String, Object> data) {
        this.data = data;
    }

    public BaseResponse add(String key, Object value) {
        this.getData().put(key, value);
        return this;
    }
}
