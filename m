Message-ID: <402D6682.80801@nortelnetworks.com>
Date: Fri, 13 Feb 2004 16:06:26 -0800
From: Abhijit Kumbhare <abhijitk@nortelnetworks.com>
MIME-Version: 1.0
References: <200402132000.i1DK09E17599@mail.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] SIOCDEVPRIVATE
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

The bridge module uses this ioctl - but in the comment in 
include/linux/sockios.h where it is defined says that the device private 
IOCTL are "deprecated" and will disappear in 2.5.X (comment by DaveM).

I still see it being used in the 2.6.X bridge code - what's the story 
behind this? Will SIOCDEVPRIVATE disappear or its just an invalid 
comment because too many people/modules are using it (that it will never 
be removed)?

Please let me know.

Thanks,
Abhijit

