package vn.hcmute.springboot4.config;

import org.apache.catalina.Context;
import org.apache.catalina.Lifecycle;
import org.apache.catalina.LifecycleEvent;
import org.apache.catalina.LifecycleListener;
import org.apache.catalina.WebResourceRoot;
import org.springframework.util.ResourceUtils;

import java.io.File;
import java.net.URI;
import java.net.URL;
import java.util.jar.JarFile;

public class JSPStaticResourceConfigurer implements LifecycleListener {

    private final Context context;
    private final String subPath = "/META-INF";

    public JSPStaticResourceConfigurer(Context context) {
        this.context = context;
    }

    @Override
    public void lifecycleEvent(LifecycleEvent event) {
        if (!event.getType().equals(Lifecycle.CONFIGURE_START_EVENT)) {
            return;
        }

        final URL finalLocation = getUrl();
        if (!hasMetaInfResources(finalLocation)) {
            return;
        }
        this.context.getResources().createWebResourceSet(
                WebResourceRoot.ResourceSetType.RESOURCE_JAR,
                "/",
                finalLocation,
                subPath
        );
    }

    private boolean hasMetaInfResources(URL location) {
        try {
            if (ResourceUtils.isFileURL(location)) {
                return new File(location.toURI()).toPath().resolve("META-INF/resources").toFile().exists();
            }
            if ("jar".equals(location.getProtocol())) {
                String path = location.getPath();
                if (path.startsWith("file:")) {
                    path = path.substring("file:".length());
                }
                int bangIndex = path.indexOf("!/");
                String archivePath = bangIndex > 0 ? path.substring(0, bangIndex) : path;
                try (JarFile jar = new JarFile(archivePath)) {
                    return jar.getEntry("META-INF/resources/") != null;
                }
            }
        } catch (Exception ignored) {
        }
        return false;
    }

    private URL getUrl() {
        final URL location = this.getClass().getProtectionDomain().getCodeSource().getLocation();

        if (ResourceUtils.isFileURL(location)) {
            return location;
        } else if (ResourceUtils.isJarURL(location)) {
            try {
                // when run as fat jar:
                // nested:/home/myfiles/Projects/myproj/myjar.jar/!BOOT-INF/classes/!/
                // -> jar:file:/home/myfiles/Projects/myproj/myjar.jar!/
                String locationStr = location.getPath()
                        .replaceFirst("^nested:", "")
                        .replaceFirst("/!(BOOT-INF|WEB-INF)/classes/!/$", "!/");

                return new URI("jar:file", locationStr, null).toURL();
            } catch (Exception e) {
                throw new IllegalStateException("Unable to add new JSP source URI to tomcat resources", e);
            }
        } else {
            throw new IllegalStateException("Can not add tomcat resources, unhandleable url: " + location);
        }
    }
}
