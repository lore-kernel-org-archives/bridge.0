Message-ID: <42C0F0E2.1000501@smartbridges.com>
Date: Tue, 28 Jun 2005 14:40:34 +0800
From: munro <munro.biswal@smartbridges.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Possibility of  copying over fdb entries. 
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org



Hi, all,

I wish to copy over fdb(forwarding database  entries) learnt over from 
one interface  onto  as  they are from another interface.

Like for eg :
 brctl showmacs br0
port no mac addr                is local?       ageing timer
  1     00:30:1a:01:6f:e4       no                 0.46
  1     00:30:1a:1c:3d:b7       yes                0.00
  2     00:30:1a:1c:3d:b8       yes                0.00

Instead of the above in line 1 if i wish to forcefully add mac  "  
00:30:1a:01:6f:e4 "  from port 2 instated of port 1.


Do i need to create a separate ioctl for it from the brctl to the kernel 
code or is thier some provision for doing it.


Regards,
Munro.

