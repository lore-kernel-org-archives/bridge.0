Message-ID: <4DB540CA.8030903@gmail.com>
Date: Mon, 25 Apr 2011 11:37:14 +0200
From: =?UTF-8?B?SXJlbmV1c3ogU3pjemXFm25pYWs=?=
 <irek.szczesniak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] mind-boggling questions
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

I have a few questions on the Linux bridge, and I would appreciate it 
if someone could answer them.

1. Why does a bridge have a MAC address?  A bridge doesn't need a MAC 
address. I understand that a Linux box might offer more than a regular 
switch, and for that you need a MAC address. But the services should 
be provided by a new tap interface added to the bridge. I believe that 
the bridge should not even be shown by ifconfig.

2. Why does a bridge take the lowest MAC address of the interfaces 
connected to it?

3. When I send broadcast frames to a bridge interface (etherwake -b -i 
br0 00:00:00:00:00:00), the frames are received by the interfaces of 
the bridge.  But when I send the frames to one of the interfaces, they 
are not broadcasted to other interfaces.  I though that the bridge 
interface (br0) behaves the same as an interface added to the bridge, 
but I was mistaken.  What are the differences?


Thanks,
Irek

-- 
Ireneusz (Irek) Szczesniak
http://www.irkos.org
