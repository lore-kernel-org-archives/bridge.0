Message-ID: <20040914134858.61482.qmail@web25105.mail.ukl.yahoo.com>
Date: Tue, 14 Sep 2004 14:48:58 +0100 (BST)
From: =?iso-8859-1?q?liam=20sharp?= <piccalo_clark@yahoo.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Bridge] Transparently bridge Vlans to eth0 
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi,

I'm using Vlans in my network as a way of preventing
pier to pier communication - I only want nodes in the
network to talk to the gateway (a linux box).

I have successfully set up lots of sub interfaces
using the vconfig too, one for each vlan. What I would
like to be able to do is remove the ip address from
each of these subinterfaces eth0.x and bridge them to
eth0. I have successfully worked through the HOWTO,
but cannot see how to adapt this to my situation. 

I want the network to appear to eth0 as if all the
nodes are on the same network - like if I didn't use
any Vlans at all.

Many thanks in aniticipation !
Piccalo



	
	
		
___________________________________________________________ALL-NEW Yahoo! Messenger - all new features - even more fun!  http://uk.messenger.yahoo.com
