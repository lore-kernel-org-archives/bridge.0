MIME-Version: 1.0
Date: Sun, 30 Aug 2009 10:15:31 +0200
Message-ID: <f05d3b1c0908300115kbd9696fw1d8d51ffd3d053e@mail.gmail.com>
From: LucaMt <lucamt74@gmail.com>
Content-Type: multipart/alternative; boundary=000e0cd1e496567aa104725785d2
Subject: [Bridge] Bridge manage code
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--000e0cd1e496567aa104725785d2
Content-Type: text/plain; charset=ISO-8859-1

Hi,
looking in the internet I have found several functions to manage bridge.
These functions are: br_add_bridge, br_del_bridge etc. These functions are
in user space or kernel space ? Developing an application (bridgeConf.so)
during loading phase of the application the undefined reference error
related to the previus functions is generated.
While in the kernel space is not defined the libbridge.h.
Are the br_*_bridge function the correct way to manage bridge through code
in user space ?
For our needs something in kernel space is useful too.

Thanks

Best Regards

Luca

--000e0cd1e496567aa104725785d2
Content-Type: text/html; charset=ISO-8859-1

Hi,<br>looking in the internet I have found several functions to manage bridge.<br>These
functions are: br_add_bridge, br_del_bridge etc. These functions are in
user space or kernel space ? Developing an application (bridgeConf.so)
during loading phase of the application the undefined reference error
related to the previus functions is generated.<br>
While in the kernel space is not defined the libbridge.h.<br>Are the br_*_bridge function the correct way to manage bridge through code in user space ?<br>For our needs something in kernel space is useful too.<br><br>Thanks<br>


<br>Best Regards<br><br>Luca<br>

--000e0cd1e496567aa104725785d2--
