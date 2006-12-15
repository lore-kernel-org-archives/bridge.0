Message-ID: <4582B8DF.2010702@cambridgebroadband.com>
Date: Fri, 15 Dec 2006 15:01:51 +0000
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
References: <AA48EE0D609E8547912F0039B5E47BC261BE14@SHI-EXCHBE1.shipara.hcltech.com>
In-Reply-To: <AA48EE0D609E8547912F0039B5E47BC261BE14@SHI-EXCHBE1.shipara.hcltech.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] bridge_list orphans in linux-2.4
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "Majjari Vikram(TLS-ESG), Bangalore" <Majjari.Vikram@hcl.in>, bridge@lists.osdl.org

Hi Majjari,

We've solved the problem now.  It turned out that the bridge_list in the
kernel was not being corrupted.   The problem was actually that
"brctl show" was only returning the last 32 bridges created.  We upped
this to 2048, which required a brctl change and also a kernel module change.

The patch is attached.

HTH,

Alex

===================================================================
RCS file: /newcvs/intel-linux/net/bridge/br_ioctl.c,v
retrieving revision 1.3
retrieving revision 1.3.14.1
diff -u -r1.3 -r1.3.14.1
--- br_ioctl.c  20 Jul 2004 10:13:42 -0000      1.3
+++ br_ioctl.c  2 Nov 2006 16:59:14 -0000       1.3.14.1
@@ -5,7 +5,7 @@
   *     Authors:
   *     Lennert Buytenhek               <buytenh@gnu.org>
   *
- *     $Id: br_ioctl.c,v 1.3 2004/07/20 10:13:42 ajz Exp $
+ *     $Id: br_ioctl.c,v 1.3.14.1 2006/11/02 16:59:14 srowe Exp $
   *
   *     This program is free software; you can redistribute it and/or
   *     modify it under the terms of the GNU General Public License
@@ -233,18 +233,22 @@

         case BRCTL_GET_BRIDGES:
         {
-               int i;
-               int indices[64];
+               int *indices;
+               int ret = 0;

-               for (i=0;i<64;i++)
-                       indices[i] = 0;
+               if (arg1 >= 2048)
+                       return -ENOMEM;
+               indices = kmalloc(arg1*sizeof(int), GFP_KERNEL);
+               if (indices == NULL)
+                       return -ENOMEM;
+
+               memset(indices, 0, arg1*sizeof(int));

-               if (arg1 > 64)
-                       arg1 = 64;
                 arg1 = br_get_bridge_ifindices(indices, arg1);
-               if (copy_to_user((void *)arg0, indices, arg1*sizeof(int)))
-                       return -EFAULT;
+               ret = copy_to_user((void *)arg0, indices, arg1*sizeof(int))
+                       ? -EFAULT : arg1;

+               kfree(indices);
                 return arg1;
         }


===================================================================
RCS file: /newcvs/third-party/bridge-utils/libbridge/libbridge_init.c,v
retrieving revision 1.3
retrieving revision 1.3.14.1
diff -u -r1.3 -r1.3.14.1
--- libbridge_init.c    25 May 2004 16:42:58 -0000      1.3
+++ libbridge_init.c    2 Nov 2006 16:59:55 -0000       1.3.14.1
@@ -158,10 +158,10 @@
  int br_make_bridge_list()
  {
         int i;
-       int ifindices[32];
+       int ifindices[2047];
         int num;

-       num = br_ioctl(BRCTL_GET_BRIDGES, (unsigned long)ifindices, 32);
+       num = br_ioctl(BRCTL_GET_BRIDGES, (unsigned long)ifindices, 2047);
         if (num < 0)
                 return errno;




Majjari Vikram(TLS-ESG), Bangalore wrote:
> Hi I have a similar problem. Can u please send me how u have solved it.
> 
>  
> 
> /*/ /*/
> 
> /*/Regards,/*/
> 
> /*/Vikram./*/////
> 
>  
> 
> DISCLAIMER:
> -----------------------------------------------------------------------------------------------------------------------
> 
> The contents of this e-mail and any attachment(s) are confidential and 
> intended for the named recipient(s) only.
> It shall not attach any liability on the originator or HCL or its 
> affiliates. Any views or opinions presented in
> this email are solely those of the author and may not necessarily 
> reflect the opinions of HCL or its affiliates.
> Any form of reproduction, dissemination, copying, disclosure, 
> modification, distribution and / or publication of
> this message without the prior written consent of the author of this 
> e-mail is strictly prohibited. If you have
> received this email in error please delete it and notify the sender 
> immediately. Before opening any mail and
> attachments please check them for viruses and defect.
> 
> -----------------------------------------------------------------------------------------------------------------------
> 

