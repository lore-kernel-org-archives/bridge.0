Message-ID: <1097297374.41676ddf020df@webmail.cuhk.edu.hk>
From: Wu Yiu Kei <wuyiukei@cuhk.edu.hk>
MIME-Version: 1.0
Content-Type: text/plain; charset=BIG5
Content-Transfer-Encoding: 8bit
Subject: [Bridge] About simple bridging using Fedora Core 2
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
Date: Sat, 09 Oct 2004 04:49:46 -0000
To: bridge@lists.osdl.org

Hi, I am a beginner of bridge. I have a problem of using Fedora Core 2 to make a
simple bridge. Here is my setup:

The bridge computer is installed with Fedore Core 2 (with the SE Linux patch).
As I know that kernel 2.6.5 is already support bridging by default, so I didn't
recompile the kernel. Then I installed bridge-utils-0.9.6-1.i386. And no
additional configuration is made. After comfirming that the 2 ethernet cards
for bridging (eth1 & eth2) are working properly, I build up a bridge by the
following commands:

#ifconfig eth1 0.0.0.0 promisc
#ifconfig eth2 0.0.0.0 promisc
#brctl addbr mybridge
#brctl addif eth1
#brctl addif eth2
#ifconfig mybridge up

Notice that eth1 is connect to the internet directly, and eth2 is connected to a
host. After setting up the bridge, I tried to use the host to access the
internet, but the behaviour is very strange. It seems that the traffic through
the bridge is extremely slow. It's too slow to request even a webpage. But some
tcp connection can really be established, like up2date. I have checked the
memory of the bridge, but it doesn't seem to be run out of memory.

So, what's wrong with my bridge? Could anyone help me?

-------------------------------------------------
This e-mail is sent by CUHK WebMail http://webmail.cuhk.edu.hk
