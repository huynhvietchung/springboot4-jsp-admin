package vn.hcmute.springboot4.config;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

public class CustomSiteMeshFilter extends ConfigurableSiteMeshFilter {

    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        builder.addDecoratorPath("/*", "web.jsp")
                .addDecoratorPath("/admin/*", "admin.jsp")
                .addExcludedPath("/login*")
                .addExcludedPath("/login/*")
                .addExcludedPath("/register*")
                .addExcludedPath("/register/*")
                .addExcludedPath("/alogin*")
                .addExcludedPath("/alogin/*")
                .addExcludedPath("/api/**")
                .addExcludedPath("/static/**")
                .addExcludedPath("/h2-console/**");
    }
}
