import java.net.*;
import java.io.*;
import java.nio.channels.*;
import java.util.Properties;

public class MavenWrapperDownloader {
    // PUBLIC_INTERFACE
    public static void main(String args[]) {
        /** Downloads the maven-wrapper.jar to .mvn/wrapper if it's missing. */
        System.out.println("- Downloader started");
        String baseDirectory = System.getProperty("maven.multiModuleProjectDirectory");
        if (baseDirectory == null) {
            baseDirectory = new File(".").getAbsolutePath();
        }
        System.out.println("- Using base directory: " + baseDirectory);

        File mavenWrapperPropertyFile = new File(baseDirectory, ".mvn/wrapper/maven-wrapper.properties");
        String url = "https://repo.maven.apache.org/maven2/io/takari/maven-wrapper/0.5.6/maven-wrapper-0.5.6.jar";
        if(mavenWrapperPropertyFile.exists()){
            FileInputStream mavenWrapperPropertyFileInputStream = null;
            try {
                mavenWrapperPropertyFileInputStream = new FileInputStream(mavenWrapperPropertyFile);
                Properties mavenWrapperProperties = new Properties();
                mavenWrapperProperties.load(mavenWrapperPropertyFileInputStream);
                url = mavenWrapperProperties.getProperty("wrapperUrl", url);
            } catch (IOException e) {
                System.out.println("- ERROR loading '" + mavenWrapperPropertyFile + "'");
            } finally {
                try {
                    if(mavenWrapperPropertyFileInputStream != null) {
                        mavenWrapperPropertyFileInputStream.close();
                    }
                } catch (IOException e) {
                    // ignore
                }
            }
        }
        System.out.println("- Downloading from: " + url);

        File outputFile = new File(baseDirectory, ".mvn/wrapper/maven-wrapper.jar");
        if(!outputFile.getParentFile().exists()) {
            if(!outputFile.getParentFile().mkdirs()) {
                System.out.println("- ERROR creating output directory '" + outputFile.getParentFile() + "'");
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
        FileOutputStream fos;
        rbc = Channels.newChannel(website.openStream());
        fos = new FileOutputStream(destination);
        fos.getChannel().transferFrom(rbc, 0, Long.MAX_VALUE);
        fos.close();
        rbc.close();
    }
}
