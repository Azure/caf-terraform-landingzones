# Setting up identity bootstrap account

The purpose of the CAF Level 0 (L0) bootstrap Azure AD application is to own the creation of the launchpads. During that process a new Azure AD application is created with less permissions on the directory and also more specific Azure permissions to fulfill the Azure operations of the
level0 (subscription creation for example)

This document explains the manual process to create the L0 Azure AD app and the following information must be captured:

| Variable             | Item                     | Value |
| -------------------- | ------------------------ | ----  |
|ARM\_CLIENT\_ID       | Application (client) ID  |       |
|ARM\_CLIENT\_SECRET   | Client secret            |       |
|ARM\_TENANT\_ID       | Directory (tenant) ID    |       |
|ARM\_SUBSCRIPTION\_ID | Subscription ID          |       |

## Create Azure AD L0 App

Go to Azure Active Directory

![](./images/image1.png)

Create a **new** Azure **Active Directory Application**

![](./images/image2.png)

![](./images/image3.png)

From the property pane select "**API permissions**"

![](./images/image4.png)

**Remove** the default one

![](./images/image5.png)

**Confirm the deletion**

![](./images/image6.png)

Click on "**Add a permission**"

![](./images/image7.png)

Select "**Application permissions**"

![](./images/image8.png)

Select from "**Application**", "**Application.ReadWrite.OwnedBy**"

![](./images/image9.png)

Then from "**Directory**" select "**Directory.ReadWrite.All**"

![](./images/image10.png)

Complete the operation by pressing the blue button "**Add permissions**"

Click again on "*Add permission*"

![](./images/image11.png)

Select the "**Microsoft Graph**"

![](./images/image12.png)

Select "**Application permissions**"

![](./images/image13.png)

From "**AppRoleAssignment**" select "**AppRoleAssignment.ReadWrite.All**"

![](./images/image14.png)

From "**DelegatedPermissionGrant**" select "**DelegatedPermissionGrant.ReadWrite.All**"

![](./images/image15.png)

From "**Directory**" select "**Directory.ReadWrite.All**"

![](./images/MSGraph_directory.png)

Complete the operation by clicking on the blue button "**Add permissions**"

You need to be logged-in with a user who has directory role "**Global Admin**" or permission to grant consents. When ready press the button "**Grant admin consent for \[name of your tenant\]**"

![](./images/Grant_Admin_Consent.png)

Confirm

![](./images/image17.png)

You can see the consents have been given with the green tick button

![](./images/Granted_Admin_Consent.png)

Now the Azure Active Directory Application has been created and given the right permission on the APIs, you need to set a complex password.

From the property pane select "**Certificates & secrets**"

![](./images/image19.png)

Click on "**New client secret**"

![](./images/image20.png)

Put a description -- *date of the creation of the secret* as an example

![](./images/image21.png)

When ready click on the blue button "Add". Note the password will be displayed only after the creation. Copy the password as you will not be able to retrieve it again later. If you missed that step, delete the password and recreate a new one.

![](./images/image22.png)

### Capture the tenant ID

![](./images/image23.png)

Capture the client ID

![](./images/image24.png)

### Capture the subscription ID

From the Azure Portal search bar, type "**Subscription**"

![](./images/image25.png)

Capture the subscription ID

![](./images/image26.png)

## Grant subscription owner to level0-security

![](./images/image25.png)

Click on the subscription

![](./images/image26.png)

Go to "**Access control (IAM)**"

![](./images/image27.png)

Select "**Add**".. "**Add role assignment**"

![](./images/image28.png)

Select Role as "**Owner**". Set the Azure Active Directory application name you created earlier.

![](./images/image29.png)

Click on the name and then on the "**save**" button

![](./images/image30.png)

If all the steps have been completed successfully, you are ready to deploy the level 0 open source launchpad.