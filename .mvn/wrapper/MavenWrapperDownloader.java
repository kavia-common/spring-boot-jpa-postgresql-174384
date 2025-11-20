import java.net.*;
import java.io.*;
import java.nio.channels.*;
import java.util.Properties;

/**
 * PUBLIC_INTERFACE
 * MavenWrapperDownloader downloads the Maven Wrapper JAR when not available,
 * allowing the project to build without a globally installed Maven.
 */
public class MavenWrapperDownloader {

    private static final String WRAPPER_VERSION = "0.5.6";
    private static final String DEFAULT_DOWNLOAD_URL =
            "https://repo.maven.apache.org/maven2/io/takari/maven-wrapper/" + WRAPPER_VERSION + "/maven-wrapper-" + WRAPPER_VERSION + ".jar";

    public static void main(String[] args) {
        System.out.println("- Downloader started");
        File baseDirectory = new File(args.length > 0 ? args[0] : ".");
        System.out.println("- Using base directory: " + baseDirectory.getAbsolutePath());

        File mavenWrapperPropertyFile = new File(baseDirectory, ".mvn/wrapper/maven-wrapper.properties");
        String url = DEFAULT_DOWNLOAD_URL;
        if (mavenWrapperPropertyFile.exists()) {
            FileInputStream mavenWrapperPropertyFileInputStream = null;
            try {
                mavenWrapperPropertyFileInputStream = new FileInputStream(mavenWrapperPropertyFile);
                Properties mavenWrapperProperties = new Properties();
                mavenWrapperProperties.load(mavenWrapperPropertyFileInputStream);
                url = mavenWrapperProperties.getProperty("wrapperUrl", url);
            } catch (IOException e) {
                System.out.println("- ERROR loading '" + mavenWrapperPropertyFile.getAbsolutePath() + "'");
            } finally {
                try {
                    if (mavenWrapperPropertyFileInputStream != null) {
                        mavenWrapperPropertyFileInputStream.close();
                    }
                } catch (IOException e) {
                    // ignore
                }
            }
        }
        System.out.println("- Downloading from: " + url);

        File outputFile = new File(baseDirectory.getAbsolutePath(), ".mvn/wrapper/maven-wrapper.jar");
        File parentDir = outputFile.getParentFile();
        if (!parentDir.exists()) {
            if (!parentDir.mkdirs()) {
                System.out.println("- ERROR creating output directory '" + parentDir.getAbsolutePath() + "'");
            }
        }
        System.out.println("- Downloading to: " + outputFile.getAbsolutePath());
        try {
            downloadFileFromURL(url, outputFile);
            System.out.println("Done");
            System.exit(0);
        } catch (Throwable e) {
            System.out.println("- Error downloading");
            e.printStackTrace();
            System.exit(1);
        }
    }

    private static void downloadFileFromURL(String urlString, File destination) throws Exception {
        if (System.getenv("MVNW_USERNAME") != null && System.getenv("MVNW_PASSWORD") != null) {
            String username = System.getenv("MVNW_USERNAME");
            char[] password = System.getenv("MVNW_PASSWORD").toCharArray();
            Authenticator.setDefault(new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(username, password);
                }
            });
        }
        URL website = new URL(urlString);
        ReadableByteChannel rbc;
        try (InputStream in = website.openStream()) {
            rbc = Channels.newChannel(in);
            try (FileOutputStream fos = new FileOutputStream(destination)) {
                fos.getChannel().transferFrom(rbc, 0, Long.MAX_VALUE);
            }
        }
    }
}
