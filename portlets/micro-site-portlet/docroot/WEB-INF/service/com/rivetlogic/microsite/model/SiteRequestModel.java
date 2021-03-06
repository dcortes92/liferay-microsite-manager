/**
 * Copyright (c) 2000-2013 Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */

package com.rivetlogic.microsite.model;

import com.liferay.portal.kernel.bean.AutoEscape;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.model.BaseModel;
import com.liferay.portal.model.CacheModel;
import com.liferay.portal.service.ServiceContext;

import com.liferay.portlet.expando.model.ExpandoBridge;

import java.io.Serializable;

import java.util.Date;

/**
 * The base model interface for the SiteRequest service. Represents a row in the &quot;rivetlogic_micro_site_SiteRequest&quot; database table, with each column mapped to a property of this class.
 *
 * <p>
 * This interface and its corresponding implementation {@link com.rivetlogic.microsite.model.impl.SiteRequestModelImpl} exist only as a container for the default property accessors generated by ServiceBuilder. Helper methods and all application logic should be put in {@link com.rivetlogic.microsite.model.impl.SiteRequestImpl}.
 * </p>
 *
 * @author steven.barba
 * @see SiteRequest
 * @see com.rivetlogic.microsite.model.impl.SiteRequestImpl
 * @see com.rivetlogic.microsite.model.impl.SiteRequestModelImpl
 * @generated
 */
public interface SiteRequestModel extends BaseModel<SiteRequest> {
	/*
	 * NOTE FOR DEVELOPERS:
	 *
	 * Never modify or reference this interface directly. All methods that expect a Site Request model instance should use the {@link SiteRequest} interface instead.
	 */

	/**
	 * Returns the primary key of this Site Request.
	 *
	 * @return the primary key of this Site Request
	 */
	public long getPrimaryKey();

	/**
	 * Sets the primary key of this Site Request.
	 *
	 * @param primaryKey the primary key of this Site Request
	 */
	public void setPrimaryKey(long primaryKey);

	/**
	 * Returns the site request ID of this Site Request.
	 *
	 * @return the site request ID of this Site Request
	 */
	public long getSiteRequestId();

	/**
	 * Sets the site request ID of this Site Request.
	 *
	 * @param siteRequestId the site request ID of this Site Request
	 */
	public void setSiteRequestId(long siteRequestId);

	/**
	 * Returns the group ID of this Site Request.
	 *
	 * @return the group ID of this Site Request
	 */
	public long getGroupId();

	/**
	 * Sets the group ID of this Site Request.
	 *
	 * @param groupId the group ID of this Site Request
	 */
	public void setGroupId(long groupId);

	/**
	 * Returns the company ID of this Site Request.
	 *
	 * @return the company ID of this Site Request
	 */
	public long getCompanyId();

	/**
	 * Sets the company ID of this Site Request.
	 *
	 * @param companyId the company ID of this Site Request
	 */
	public void setCompanyId(long companyId);

	/**
	 * Returns the user ID of this Site Request.
	 *
	 * @return the user ID of this Site Request
	 */
	public long getUserId();

	/**
	 * Sets the user ID of this Site Request.
	 *
	 * @param userId the user ID of this Site Request
	 */
	public void setUserId(long userId);

	/**
	 * Returns the user uuid of this Site Request.
	 *
	 * @return the user uuid of this Site Request
	 * @throws SystemException if a system exception occurred
	 */
	public String getUserUuid() throws SystemException;

	/**
	 * Sets the user uuid of this Site Request.
	 *
	 * @param userUuid the user uuid of this Site Request
	 */
	public void setUserUuid(String userUuid);

	/**
	 * Returns the create date of this Site Request.
	 *
	 * @return the create date of this Site Request
	 */
	public Date getCreateDate();

	/**
	 * Sets the create date of this Site Request.
	 *
	 * @param createDate the create date of this Site Request
	 */
	public void setCreateDate(Date createDate);

	/**
	 * Returns the modified date of this Site Request.
	 *
	 * @return the modified date of this Site Request
	 */
	public Date getModifiedDate();

	/**
	 * Sets the modified date of this Site Request.
	 *
	 * @param modifiedDate the modified date of this Site Request
	 */
	public void setModifiedDate(Date modifiedDate);

	/**
	 * Returns the name of this Site Request.
	 *
	 * @return the name of this Site Request
	 */
	@AutoEscape
	public String getName();

	/**
	 * Sets the name of this Site Request.
	 *
	 * @param name the name of this Site Request
	 */
	public void setName(String name);

	/**
	 * Returns the description of this Site Request.
	 *
	 * @return the description of this Site Request
	 */
	@AutoEscape
	public String getDescription();

	/**
	 * Sets the description of this Site Request.
	 *
	 * @param description the description of this Site Request
	 */
	public void setDescription(String description);

	/**
	 * Returns the status of this Site Request.
	 *
	 * @return the status of this Site Request
	 */
	@AutoEscape
	public String getStatus();

	/**
	 * Sets the status of this Site Request.
	 *
	 * @param status the status of this Site Request
	 */
	public void setStatus(String status);

	/**
	 * Returns the response of this Site Request.
	 *
	 * @return the response of this Site Request
	 */
	@AutoEscape
	public String getResponse();

	/**
	 * Sets the response of this Site Request.
	 *
	 * @param response the response of this Site Request
	 */
	public void setResponse(String response);

	/**
	 * Returns the site ID of this Site Request.
	 *
	 * @return the site ID of this Site Request
	 */
	public long getSiteId();

	/**
	 * Sets the site ID of this Site Request.
	 *
	 * @param siteId the site ID of this Site Request
	 */
	public void setSiteId(long siteId);

	@Override
	public boolean isNew();

	@Override
	public void setNew(boolean n);

	@Override
	public boolean isCachedModel();

	@Override
	public void setCachedModel(boolean cachedModel);

	@Override
	public boolean isEscapedModel();

	@Override
	public Serializable getPrimaryKeyObj();

	@Override
	public void setPrimaryKeyObj(Serializable primaryKeyObj);

	@Override
	public ExpandoBridge getExpandoBridge();

	@Override
	public void setExpandoBridgeAttributes(BaseModel<?> baseModel);

	@Override
	public void setExpandoBridgeAttributes(ExpandoBridge expandoBridge);

	@Override
	public void setExpandoBridgeAttributes(ServiceContext serviceContext);

	@Override
	public Object clone();

	@Override
	public int compareTo(com.rivetlogic.microsite.model.SiteRequest siteRequest);

	@Override
	public int hashCode();

	@Override
	public CacheModel<com.rivetlogic.microsite.model.SiteRequest> toCacheModel();

	@Override
	public com.rivetlogic.microsite.model.SiteRequest toEscapedModel();

	@Override
	public com.rivetlogic.microsite.model.SiteRequest toUnescapedModel();

	@Override
	public String toString();

	@Override
	public String toXmlString();
}