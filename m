Return-Path: <joakim.tjernlund@transmode.se>
Message-ID: <OF120A5AA1.1637AABA-ONC12579AC.0053568E-C12579AC.0053E53D@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 22 Feb 2012 16:16:21 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: [Bridge] Strange STP hello timing problem
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org


Have 3 bridges in serie:

A - B - C
A is designated root.

In B I can see with tcpdump that I receive STP Hellos ever 2 secs from A, this is normal.
However B forwards hellos to C every 20 secs( max age timer). This makes topo calculation
go into spin every now and then. Should not B forward hellos as they come from A(every 2 secs)?

 Jocke

