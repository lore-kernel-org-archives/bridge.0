From: "Rajaraman S" <rajaraman@idealab-india.com>
Date: Thu, 4 Mar 2004 16:37:27 +0530
Message-ID: <000001c401d8$e2532500$0618a8c0@rajaraman>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Bridge firewall
Reply-To: rajaraman@idealab-india.com
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

Hi,

I'm relatively new to linux world.I'm just trying to setup a bridge firewall
between a router and LAN.

I've installed Red Hat Linux 9.0 - 2.4.20-8 from installation CDs and
upgraded to 2.4.25 successfully.

I've patched my kernel to support bridge firewall also loaded ebtables
module,so far so good.Now I tried to create a bridge using the code given in
the following link
http://www.sjdjweis.com/linux/bridging/bridge

I ran the script,and then i typed 'brctl show' to check whether the bridge
is up.It showed the created bridge but in the next few seconds machine froze
completely.I had to restart the machine.I've tried doing the same thing four
to five times but each time it froze after i created the bridge.What's
happening???

Do I need to upgrade the kernel with any other patch or am I missing
something very obvious.

Expecting your reply.

Thanks & Regards,
S.Rajaraman
iDeaLab India Pvt Ltd




