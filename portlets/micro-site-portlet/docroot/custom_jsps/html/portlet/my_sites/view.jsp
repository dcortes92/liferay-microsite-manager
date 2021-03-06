<%--
/**
 * Copyright (c) 2000-2013 Liferay, Inc. All rights reserved.
 *
 * The contents of this file are subject to the terms of the Liferay Enterprise
 * Subscription License ("License"). You may not use this file except in
 * compliance with the License. You can obtain a copy of the License by
 * contacting Liferay, Inc. See the License for the specific language governing
 * permissions and limitations under the License, including but not limited to
 * distribution rights of the Software.
 *
 *
 *
 */
--%>

<%@ include file="/html/portlet/sites_admin/init.jsp" %>

<%-- Rivet Custom Imports --%>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.List" %>
<%@page import="java.util.Map" %>
<%@page import="com.liferay.portal.kernel.util.ListUtil" %>
<%-- Rivet Custom Imports --%>

<%
String tabs1 = ParamUtil.getString(request, "tabs1", "my-sites");

PortletURL portletURL = renderResponse.createRenderURL();

portletURL.setParameter("struts_action", "/my_sites/view");
portletURL.setParameter("tabs1", tabs1);

pageContext.setAttribute("portletURL", portletURL);

request.setAttribute("view.jsp-tabs1", tabs1);

//-- Rivet Custom Code --
// Uses a generic List and Map because the SiteRequest class is not available in the global ClassLoader.
List<Map> siteRequestsValues = (List<Map>) request.getAttribute("siteRequestsList");
SimpleDateFormat simpleDateFormat = new SimpleDateFormat("d/M/y");
//-- Rivet Custom Code --
%>

<liferay-ui:success key="membershipRequestSent" message="your-request-was-sent-you-will-receive-a-reply-by-email" />
<liferay-ui:tabs
		names="my-sites,available-sites,micro-sites-requests"
		url="<%= portletURL.toString() %>"
	/>
	
	<%--Rivet Custom Code --%>
	<% if(tabs1.equals("my-sites") || tabs1.equals("available-sites")) { %>
	<%--Rivet Custom Code --%>
	
<aui:form action="<%= portletURL.toString() %>" method="get" name="fm">
	<liferay-portlet:renderURLParams varImpl="portletURL" />

	

	
	<liferay-ui:search-container
		searchContainer="<%= new GroupSearch(renderRequest, portletURL) %>"
	>

		<%
		GroupSearchTerms searchTerms = (GroupSearchTerms)searchContainer.getSearchTerms();

		LinkedHashMap<String, Object> groupParams = new LinkedHashMap<String, Object>();

		groupParams.put("site", Boolean.TRUE);

		if (tabs1.equals("my-sites")) {
			groupParams.put("usersGroups", new Long(user.getUserId()));
			groupParams.put("active", Boolean.TRUE);
		}
		else if (tabs1.equals("available-sites")) {
			List types = new ArrayList();

			types.add(new Integer(GroupConstants.TYPE_SITE_OPEN));
			types.add(new Integer(GroupConstants.TYPE_SITE_RESTRICTED));

			groupParams.put("types", types);
			groupParams.put("active", Boolean.TRUE);
		}
		%>

		<liferay-ui:search-container-results>

			<%
			if (searchTerms.isAdvancedSearch()) {
				total = GroupLocalServiceUtil.searchCount(company.getCompanyId(), searchTerms.getName(), searchTerms.getDescription(), groupParams, searchTerms.isAndOperator());

				searchContainer.setTotal(total);

				results = GroupLocalServiceUtil.search(company.getCompanyId(), searchTerms.getName(), searchTerms.getDescription(), groupParams, searchTerms.isAndOperator(), searchContainer.getStart(), searchContainer.getEnd(), searchContainer.getOrderByComparator());
			}
			else {
				total = GroupLocalServiceUtil.searchCount(company.getCompanyId(), searchTerms.getKeywords(), groupParams);

				searchContainer.setTotal(total);

				results = GroupLocalServiceUtil.search(company.getCompanyId(), searchTerms.getKeywords(), groupParams, searchContainer.getStart(), searchContainer.getEnd(), searchContainer.getOrderByComparator());
			}

			searchContainer.setResults(results);
			%>

		</liferay-ui:search-container-results>

		<aui:nav-bar>
			<aui:nav-bar-search cssClass="pull-right" file="/html/portlet/users_admin/group_search.jsp" searchContainer="<%= searchContainer %>" />
		</aui:nav-bar>

		<liferay-ui:error exception="<%= RequiredGroupException.class %>">

			<%
			RequiredGroupException rge = (RequiredGroupException)errorException;
			%>

			<c:if test="<%= rge.getType() == RequiredGroupException.CURRENT_GROUP %>">
				<liferay-ui:message key="you-cannot-delete-this-site-because-you-are-currently-accessing-this-site" />
			</c:if>

			<c:if test="<%= rge.getType() == RequiredGroupException.PARENT_GROUP %>">
				<liferay-ui:message key="you-cannot-delete-sites-that-have-subsites" />
			</c:if>

			<c:if test="<%= rge.getType() == RequiredGroupException.SYSTEM_GROUP %>">
				<liferay-ui:message key="the-site-cannot-be-deleted-or-deactivated-because-it-is-a-required-system-site" />
			</c:if>
		</liferay-ui:error>

		<liferay-ui:search-container-row
			className="com.liferay.portal.model.Group"
			keyProperty="groupId"
			modelVar="group"
			rowIdProperty="friendlyURL"
		>

			<%
			PortletURL rowURL = null;

			if (group.getPublicLayoutsPageCount() > 0) {
				rowURL = renderResponse.createActionURL();

				rowURL.setParameter("struts_action", "/sites_admin/page");
				rowURL.setParameter("redirect", currentURL);
				rowURL.setParameter("groupId", String.valueOf(group.getGroupId()));
				rowURL.setParameter("privateLayout", Boolean.FALSE.toString());
				rowURL.setWindowState(WindowState.NORMAL);
			}
			else if (tabs1.equals("my-sites") && (group.getPrivateLayoutsPageCount() > 0)) {
				rowURL = renderResponse.createActionURL();

				rowURL.setParameter("struts_action", "/sites_admin/page");
				rowURL.setParameter("redirect", currentURL);
				rowURL.setParameter("groupId", String.valueOf(group.getGroupId()));
				rowURL.setParameter("privateLayout", Boolean.TRUE.toString());
				rowURL.setWindowState(WindowState.NORMAL);
			}
			%>

			<liferay-ui:search-container-column-text
				buffer="buffer"
				name="name"
				orderable="<%= true %>"
			>

			<%
			if (rowURL != null) {
				buffer.append("<a href=\"");
				buffer.append(rowURL.toString());
				buffer.append("\" target=\"_blank\"><strong>");
				buffer.append(HtmlUtil.escape(group.getDescriptiveName(locale)));
				buffer.append("</strong></a>");
			}
			else {
				buffer.append("<strong>");
				buffer.append(HtmlUtil.escape(group.getDescriptiveName(locale)));
				buffer.append("</strong>");
			}

			if (!tabs1.equals("my-sites") && Validator.isNotNull(group.getDescription())) {
				buffer.append("<br /><em>");
				buffer.append(HtmlUtil.escape(group.getDescription()));
				buffer.append("</em>");
			}
			%>

			</liferay-ui:search-container-column-text>

			<%
			LinkedHashMap<String, Object> userParams = new LinkedHashMap<String, Object>();

			userParams.put("inherit", Boolean.TRUE);
			userParams.put("usersGroups", new Long(group.getGroupId()));
			%>

			<liferay-ui:search-container-column-text
				name="members"
				value="<%= String.valueOf(UserLocalServiceUtil.searchCount(company.getCompanyId(), null, WorkflowConstants.STATUS_APPROVED, userParams)) %>"
			/>

			<c:if test='<%= tabs1.equals("my-sites") && PropsValues.LIVE_USERS_ENABLED %>'>
				<liferay-ui:search-container-column-text
					name="online-now"
					value="<%= String.valueOf(LiveUsers.getGroupUsersCount(company.getCompanyId(), group.getGroupId())) %>"
				/>
			</c:if>

			<liferay-ui:search-container-column-text
				name="tags"
			>
				<liferay-ui:asset-tags-summary
					className="<%= Group.class.getName() %>"
					classPK="<%= group.getGroupId() %>"
				/>
			</liferay-ui:search-container-column-text>

			<liferay-ui:search-container-column-jsp
				align="right"
				path="/html/portlet/my_sites/site_action.jsp"
			/>

		</liferay-ui:search-container-row>

		<liferay-ui:search-iterator />
	</liferay-ui:search-container>
	
</aui:form>
<%-- Rivet Custom Code --%>
<% } else { %>
		<div id="<portlet:namespace/>list-container">
		<c:if test="<%=themeDisplay.isSignedIn()%>">
			<aui:button name="new-request-button" value="site-request-new" cssClass="btn btn-large btn-primary icon-plus"/>
		</c:if>

		<liferay-ui:search-container curParam="requestsCur" delta="10" emptyResultsMessage="no-site-requests-were-found"
			iteratorURL="<%=portletURL %>">
			<liferay-ui:search-container-results 
				results="<%= ListUtil.subList(siteRequestsValues, searchContainer.getStart(), searchContainer.getEnd()) %>" 
				total="<%= siteRequestsValues.size() %>"/>
			<liferay-ui:search-container-row className="java.util.Map" modelVar="siteRequest">
				<liferay-ui:search-container-column-text name="site-request-name">
					<%= siteRequest.get("name") %>
				</liferay-ui:search-container-column-text>
				<liferay-ui:search-container-column-text name="site-request-updated">
					<%= simpleDateFormat.format(siteRequest.get("modifiedDate")) %>
				</liferay-ui:search-container-column-text>
				<liferay-ui:search-container-column-text name="site-request-status">
					<%
						String status = (String) siteRequest.get("status"); 
						String statusMessage = "site-request-status-" + siteRequest.get("status"); 
					%>
					<liferay-ui:message key="<%= statusMessage %>" />
					<c:if test='<%=status.equals("rejected") %>'>
						-&nbsp;<%=siteRequest.get("response") %>
					</c:if>
				</liferay-ui:search-container-column-text>
			</liferay-ui:search-container-row>
			<liferay-ui:search-iterator searchContainer="<%=searchContainer %>"/>
		</liferay-ui:search-container>
		</div>
		
		<div id="<portlet:namespace/>form-container" class="hide">
			<portlet:actionURL var="actionURL">
				<portlet:param name="struts_action" value="/add_site_request"/>
				<portlet:param name="redirect" value="<%=currentURL %>"/>
				<portlet:param name="add_site" value="true"/>
			</portlet:actionURL>
			<aui:form action="<%= actionURL %>">
				<aui:fieldset>
					<aui:input name="name" label="name" helpMessage="site-request-name-help">
						<aui:validator name="required" />
					</aui:input>
					<aui:input type="textarea" name="description" label="description" helpMessage="site-request-description-help">
						<aui:validator name="required" />
						<aui:validator name="maxLength">75</aui:validator>
					</aui:input>
					<aui:button value="send" type="submit"/>
					<aui:button value="cancel" name="cancel-button"/>
				</aui:fieldset>
			</aui:form>
		</div>
		
		<aui:script use="aui-base,aui-node">
			function changeView() {
				A.one('#<portlet:namespace/>fm').reset();
				A.one('#<portlet:namespace/>list-container').toggleView();
				A.one('#<portlet:namespace/>form-container').toggleView();
			}
			A.one('#<portlet:namespace/>new-request-button').on('click', function(e){
				changeView();
			});
			A.one('#<portlet:namespace/>cancel-button').on('click', function(e){
				changeView();
			});
		</aui:script>
<% } %>
<%-- Rivet Custom Code --%>