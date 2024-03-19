---
title: Android与Unity交互之AndroidJavaProxy回调的使用
author: cypunberk.admin
tags:
  - Unity
  - Android
  - sdk
categories:
  - Android
  - Unity
date: 2023-04-20 14:46:00
img: https://raw.githubusercontent.com/oO0OoOo/cpblog-hexo/main/source/images/bg/591039294a193.jpg
---
以实际需求为例，比如要实现一个Android原生的Dialog弹窗，通过Unity调用使其打开，同时注册弹窗上【确定】和【返回】键的点击回调。  
首先创建一个C#类，继承自AndroidJavaProxy  
注意构造函数内的参数，后续会在java端创建一个与之同名的接口
```C#
public class DialogClickCallback : AndroidJavaProxy
    {
        public Action OnConfirmClick;
		public Action OnCancelClick;

        public DialogClickCallback() : base("com.aaa.bbb.listener.ICustomDialogCallback"){ }
        
        //invoked by java
        public void onConfirm()
        {
			OnConfirmClick?.Invoke();	
        }
		
		//invoked by java
        public void onCancel()
        {
			OnCancelClick?.Invoke();	
        }
    }
```
  
接下来在Android工程内新建java接口
```java
package com.aaa.bbb.listener;

public interface ICustomDialogCallback {
    void onConfirm();
    void onCancel();
}
```

然后在java端实现一个简单的窗口类

```java
public class CustomDialog extends Dialog{

    private Button ok;//确定按钮
    private Button cancel;//取消按钮
    private TextView titleTV;//消息标题文本
    private TextView message;//消息提示文本
    private String titleStr;//从外界设置的title文本
    private String messageStr;//从外界设置的消息文本
    //确定文本和取消文本的显示的内容
    private String yesStr, noStr;
    private ICustomDialogCallback callback;

    private boolean cancelBtnVisible = true;            //cancel按钮是否显示
    private boolean autoCloseOnAnyClick = true;        //是否在点击confirm或cancel按钮一次后自动关闭该窗口
    public CustomDialog(@NonNull Context context) {
        super(context);
    }

    public CustomDialog(@NonNull Context context, int themeResId) {
        super(context, themeResId);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.custom_dialog);
        this.setCanceledOnTouchOutside(false);
        ok = findViewById(R.id.btn_confirm);
        cancel = findViewById(R.id.btn_cancel);
        titleTV = findViewById(R.id.tv_dialog_title);
        message = findViewById(R.id.tv_dialog_body);

        //初始化界面数据
        initData();
        //初始化界面控件的事件
        initEvent();
    }
    /**
     * 初始化界面控件的显示数据
     */
    private void initData() {
        //如果用户自定了title和message
        if (titleStr != null) {
            titleTV.setText(titleStr);
        }
        if (messageStr != null) {
            message.setText(messageStr);
        }
        //如果设置按钮文字
        if (yesStr != null) {
            ok.setText(yesStr);
        }
        if (noStr != null) {
            cancel.setText(noStr);
        }
        if(cancelBtnVisible)
        {
            cancel.setVisibility(View.VISIBLE);
        }else
        {
            cancel.setVisibility(View.GONE);
        }
    }

    /**
     * 初始化界面的确定和取消监听
     */
    private void initEvent() {
        //设置确定按钮被点击后，向外界提供监听
        ok.setOnClickListener(v -> {
            if(autoCloseOnAnyClick)
            { this.dismiss(); }
            if (callback != null) {
                callback.onConfirm();
            }
        });
        //设置取消按钮被点击后，向外界提供监听
        cancel.setOnClickListener(v -> {
            if(autoCloseOnAnyClick)
            { this.dismiss(); }
            if (callback != null) {
                callback.onCancel();
            }
        });
    }

    public void setTitle(String title) {
        titleStr = title;
    }

    public void setMessage(String message) {
        messageStr = message;
    }

    public void setConfirmStr(String str)
    {
        yesStr = str;
    }

    public void setCancelStr(String str)
    {
        noStr = str;
    }

    public void setAutoCloseOnAnyClick(boolean value)
    {
        autoCloseOnAnyClick = value;
    }

    public void setOnClickListener(ICustomDialogCallback callback)
    {
        this.callback = callback;
    }

    public void setCancelBtnVisible(boolean visible)
    {
        this.cancelBtnVisible = visible;
    }

    public void onBackPressed() {
    }

    public void show() {
        super.show();
        DisplayMetrics displayMetrics = this.getContext().getResources().getDisplayMetrics();
        if (this.getContext().getResources().getConfiguration().orientation == 2) {
            this.getWindow().setLayout(displayMetrics.widthPixels / 4 * 3, displayMetrics.heightPixels / 5 * 4);
        } else {
            this.getWindow().setLayout(displayMetrics.widthPixels / 5 * 4, displayMetrics.heightPixels / 6 * 2);
        }
    }
}
```

为了方便C#端调用，可以将打开Dialog弹窗并设置参数的行为封装进一个接口，这样每次显示弹窗C#只需要进行一次java调用

```java
package com.aaa.bbb;

public class MainInterface
{
    public static void ShowDialog(String title, String content, String confirmText, String cancelText, boolean autoCloseOnAnyClick, ICustomDialogCallback callback)
    {
        CustomDialog dialog = new CustomDialog(Utils.GetCurrentActivity());
        dialog.setMessage(content);
        dialog.setTitle(title);
        dialog.setConfirmStr(confirmText);
        dialog.setCancelStr(cancelText);
        dialog.setAutoCloseOnAnyClick(autoCloseOnAnyClick);
        dialog.setCancelBtnVisible(cancelText != null && !cancelText.isEmpty());
        dialog.show();
        dialog.setOnClickListener(callback);
    }
}

```

至此，java端的开发就完成了，接着让C#调用MainInterface.ShowDialog方法

```C#
public void ShowDialog(string title, string content, string confirmText, string cancelText, bool autoCloseOnAnyClick, Action onConfirm, Action onCancel)
        {
            DialogClickCallback cb = new DialogClickCallback()
            {
                OnConfirmClick = () => onConfirm?.Invoke(),
                OnCancelClick = () => onCancel?.Invoke(),
            };
            AndroidJavaClass mainInterface = new AndroidJavaClass("com.aaa.bbb.MainInterface");
            mainInterface.CallStatic("ShowDialog", title, content, confirmText, cancelText, autoCloseOnAnyClick, cb);
        }
```

全部完成。