Message-ID: <40743FBA.70908@maschtera.at>
Date: Wed, 07 Apr 2004 19:51:54 +0200
From: Wilfried Maschtera <wilfried.maschtera@maschtera.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] compiling  bridge-utils-0.9.6
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

Linux SuSe 9.0, kernel 2.24.21-166...

I got the error

libbridge_misc.c: In function `__tv_to_jiffies':
libbridge_misc.c:33: error: `HZ' undeclared (first use in this function)
libbridge_misc.c:33: error: (Each undeclared identifier is reported only 
once
libbridge_misc.c:33: error: for each function it appears in.)
libbridge_misc.c: In function `__jiffies_to_tv':
libbridge_misc.c:40: error: `HZ' undeclared (first use in this function)
make[1]: *** [libbridge_misc.o] Error 1

I  could not find any hints.

Regards, Wilfried

