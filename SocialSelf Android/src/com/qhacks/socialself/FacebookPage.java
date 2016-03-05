package com.qhacks.socialself;

import android.app.Activity;
import android.os.Bundle;
import android.content.Intent;
import android.webkit.WebView;

/**
 * Created by Marco Ly on 2016-03-05.
 */
public class FacebookPage extends Activity {
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        //Get url from intent
        Intent intent = getIntent();
        String message = intent.getStringExtra(MainActivity.EXTRA_URL);
        WebView myWebView = new WebView(this);
        setContentView(myWebView);
        myWebView.loadUrl(message);
    }
}