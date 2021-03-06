
{{- define "config.opensrp.web.xml" }}
<?xml version="1.0" encoding="ISO-8859-1" standalone="no"?>
<web-app xmlns="http://java.sun.com/xml/ns/j2ee" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="4.0"
         xsi:schemaLocation="http://java.sun.com/xml/ns/j2ee http://java.sun.com/xml/ns/j2ee/web-app_4_0.xsd">

    <display-name>opensrp-server</display-name>

    <description>OpenSRP Web Application</description>

	<resource-ref>
		<description>Postgress DB Connection</description>
		<res-ref-name>jdbc/openSRPDB</res-ref-name>
		<res-type>javax.sql.DataSource</res-type>
		<res-auth>Container</res-auth>
	</resource-ref>

    <!-- Enable escaping of form submission contents -->
    <context-param>
        <param-name>defaultHtmlEscape</param-name>
        <param-value>true</param-value>
    </context-param>

    <context-param>
        <param-name>contextConfigLocation</param-name>
        <param-value>classpath*:spring/applicationContext-opensrp-web.xml</param-value>
    </context-param>

    <filter>
        <filter-name>CharacterEncodingFilter</filter-name>
        <filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>
        <init-param>
            <param-name>encoding</param-name>
            <param-value>UTF-8</param-value>
        </init-param>
        <init-param>
            <param-name>forceEncoding</param-name>
            <param-value>true</param-value>
        </init-param>
    </filter>

    <filter>
        <filter-name>HttpMethodFilter</filter-name>
        <filter-class>org.springframework.web.filter.HiddenHttpMethodFilter</filter-class>
    </filter>

    <filter>
        <filter-name>springSecurityFilterChain</filter-name>
        <filter-class>org.springframework.web.filter.DelegatingFilterProxy</filter-class>
    </filter>

    <filter>
        <filter-name>AuthenticationFilter</filter-name>
        <filter-class>org.opensrp.web.AuthenticationFilter</filter-class>
    </filter>

     <filter>
        <filter-name>GZipFilter</filter-name>
        <filter-class>org.opensrp.web.GZipCompressionFilter</filter-class>
    </filter>

     <filter>
        <filter-name>GzipBodyDecompressFilter</filter-name>
        <filter-class>org.opensrp.web.GzipBodyDecompressFilter</filter-class>
    </filter>

    <filter>
        <filter-name>springSessionRepositoryFilter</filter-name>
        <filter-class>org.springframework.web.filter.DelegatingFilterProxy</filter-class>
    </filter>

    <filter>
        <filter-name>CrossSiteScriptingPreventionFilter</filter-name>
        <filter-class>org.opensrp.web.config.security.filter.CrossSiteScriptingPreventionFilter</filter-class>
    </filter>

    <filter-mapping>
        <filter-name>AuthenticationFilter</filter-name>
        <url-pattern>/authenticate-user/</url-pattern>
    </filter-mapping>

    <filter-mapping>
        <filter-name>springSecurityFilterChain</filter-name>
        <url-pattern>/*</url-pattern>
    </filter-mapping>

    <filter-mapping>
        <filter-name>CharacterEncodingFilter</filter-name>
        <url-pattern>/*</url-pattern>
    </filter-mapping>

    <filter-mapping>
        <filter-name>HttpMethodFilter</filter-name>
        <url-pattern>/*</url-pattern>
    </filter-mapping>

    <filter-mapping>
        <filter-name>GZipFilter</filter-name>
        <url-pattern>/*</url-pattern>
    </filter-mapping>

	<filter-mapping>
		<filter-name>GzipBodyDecompressFilter</filter-name>
		<url-pattern>/*</url-pattern>
	</filter-mapping>

    <filter-mapping>
        <filter-name>springSessionRepositoryFilter</filter-name>
        <url-pattern>/*</url-pattern>
    </filter-mapping>

    <filter-mapping>
        <filter-name>CrossSiteScriptingPreventionFilter</filter-name>
        <url-pattern>/*</url-pattern>
    </filter-mapping>

    <!-- Creates the Spring Container shared by all Servlets and Filters -->
    <listener>
        <listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
    </listener>

	<listener>
		<listener-class>org.springframework.security.web.session.HttpSessionEventPublisher</listener-class>
	</listener>

	<context-param>
		<param-name>spring.profiles.active</param-name>
		<param-value>{{ .Values.spring_active_profiles | join "," }}</param-value>
	</context-param>

    <!-- Handles Spring requests -->
    <servlet>
        <servlet-name>opensrp</servlet-name>
        <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
        <init-param>
            <param-name>contextConfigLocation</param-name>
            <param-value>/WEB-INF/spring/webmvc-config.xml</param-value>
        </init-param>
        <load-on-startup>1</load-on-startup>
    </servlet>

    <servlet-mapping>
        <servlet-name>opensrp</servlet-name>
        <url-pattern>/</url-pattern>
    </servlet-mapping>

    <session-config>
        <session-timeout>120</session-timeout>
    </session-config>

    <error-page>
        <location>/error</location>
    </error-page>
</web-app>

{{- end }}
