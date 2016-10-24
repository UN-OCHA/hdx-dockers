<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE log4j:configuration PUBLIC "-//APACHE//DTD LOG4J 1.2//EN"
    "http://logging.apache.org/log4j/1.2/apidocs/org/apache/log4j/xml/doc-files/log4j.dtd">
<log4j:configuration>

  <!-- =================================== === APPENDERS =================================== -->

  <appender name="hdx-file-core" class="org.apache.log4j.RollingFileAppender">
    <param name="file" value="${HDX_FOLDER}/logs/hdx.log" />
    <param name="MaxFileSize" value="500KB" />
    <param name="MaxBackupIndex" value="20" />
    <layout class="org.apache.log4j.PatternLayout">
      <param name="ConversionPattern" value="%-5p %d{yy-MM-dd HH:mm:ss}: %m (%F:%L) [%t]%n" />
    </layout>
  </appender>

  <appender name="hdx-console" class="org.apache.log4j.ConsoleAppender">
    <layout class="org.apache.log4j.PatternLayout">
      <param name="ConversionPattern" value="%-5p %d{yy-MM-dd HH:mm:ss}: %m (%F:%L) [%t]%n" />
    </layout>
  </appender>

  <!-- =================================== === PACKAGE-LEVEL logging settings =================================== -->

  <!-- ======== Hibernate -->
  <logger name="org.hibernate">
    <level value="warn" />
  </logger>
  <logger name="org.postgresql">
    <level value="warn" />
  </logger>
  <!-- Hibernate generated SQL -->
  <logger name="org.hibernate.SQL" additivity="false">
    <level value="warn" />
    <appender-ref ref="hdx-console" />
  </logger>
  <!-- Hibernate abstract syntax trees for parsing predefined JPQL queries -->
  <logger name="org.hibernate.hql.ast">
    <level value="warn" />
  </logger>

  <logger name="org.apache.http">
    <level value="warn" />
  </logger>

  <!-- ======== c3p0 -->
  <logger name="com.mchange">
    <level value="warn" />
  </logger>

  <!-- ======== Spring -->
  <logger name="org.springframework">
    <level value="warn" />
  </logger>

  <!-- ======== HDX -->

  <logger name="org.ocha" additivity="false">
    <level value="warn" />
    <appender-ref ref="hdx-file-core" />
    <appender-ref ref="hdx-console" />
  </logger>

  <!--  #logger -->
  <logger name="ckan-updater-logger" additivity="false">
    <level value="warn" />
    <appender-ref ref="hdx-ckan-updater-job" />
    <appender-ref ref="hdx-console" />
  </logger>

  <!-- =================================== === ROOT Logger settings =================================== -->

  <root>
    <priority value="debug"></priority>
    <appender-ref ref="hdx-file-core" />
  </root>

  <!-- #appender -->
  <appender name="hdx-ckan-updater-job" class="org.apache.log4j.RollingFileAppender">
    <param name="file" value="${HDX_FOLDER}/logs/ckanUpdaterJob.log" />
    <param name="MaxFileSize" value="500KB" />
    <param name="MaxBackupIndex" value="20" />
    <layout class="org.apache.log4j.PatternLayout">
      <param name="ConversionPattern" value="%-5p %d{yy-MM-dd HH:mm:ss}: %m (%F:%L) [%t]%n" />
    </layout>
  </appender>



</log4j:configuration>
