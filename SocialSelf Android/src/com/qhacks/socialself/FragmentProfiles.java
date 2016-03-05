package com.qhacks.socialself;

import android.content.Intent;
import android.support.v4.app.Fragment;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.WebView;

/**
 * Created by Marco Ly on 2016-03-05.
 */
public class FragmentProfiles extends Fragment {
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        ViewGroup rootView = (ViewGroup) inflater.inflate(
                R.layout.fragment_profiles, container, false);

        return rootView;
    }

    public void createPage(String pageUrl) {
        WebView myWebView = (WebView)getView().findViewById(R.id.webview);
        myWebView.loadUrl(pageUrl);
    }
}