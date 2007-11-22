DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=beta;
	h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
	bh=i6e8yoK26DGvcBVuaZH4mtfmvpjBTd+Ber7gYFhx3YE=;
	b=HhBbTmRXiuw4WqPQglrWvEhEOEU5g1dL9t7wroJ/UZ/l57lT4WcmMSUGEzYQ5oQt7A5/lcblNnLrE8sSvraJ3IBIF6GJ7iFEyAmlU7h2JpDWn/rp4vXYjHWy0kARdXuiDUPTDnNwS2VOUKLRuP4nc138unXd9BcQprHjKD/SV1k=
Message-ID: <81c11a560711220316n60921656md0aaefd95a82e63a@mail.gmail.com>
Date: Thu, 22 Nov 2007 12:16:38 +0100
From: "Edouard Thuleau" <doudouyam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Bridge] Conflict between net/if.h and linux/if.h
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi,

I use the libbridge and an other lib (libnl) in a same project.
I include the headers files of the two lib (libnl first and libbridgge
after) and I've a conflict with the inclusion of linux/if.h (in libnl
headers) and net/if.h (in libbridge.h), I've this error :

/usr/include/net/if.h:45: error: parse error before numeric constant
/usr/include/net/if.h:111: error: redefinition of `struct ifmap'
/usr/include/net/if.h:126: error: redefinition of `struct ifreq'
/usr/include/net/if.h:176: error: redefinition of `struct ifconf'

I modify the libbridge.h to include the net/if.h only if the
linux/if.h is not define :

--- libbridge.h 2007-11-22 12:16:17.000000000 +0100
+++ libbridge_modify.h  2007-11-22 12:15:58.000000000 +0100
@@ -19,7 +19,9 @@
 #ifndef _LIBBRIDGE_H
 #define _LIBBRIDGE_H

+#ifndef _LINUX_IF_H
 #include <net/if.h>
+#endif
 #include <linux/if_bridge.h>

 struct bridge_id


Do you think it's a good solution ?
Doude.
