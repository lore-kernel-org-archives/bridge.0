Message-Id: <200503171032.j2HAWqCU025245@thewayout.net>
From: "Osama Abu Elsorour" <osama@wayout.net>
Date: Thu, 17 Mar 2005 12:32:55 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Bridge] max number of enslaved devices
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

What is the maximum number of devices that can be enslaved in a bridge
interface?

I have tried enslaving 512 devices. Although the brctl tool did not complain
while adding them, when I use brctl show command it only shows 255.

Thanks

