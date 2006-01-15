Message-ID: <20060115174355.90128.qmail@web33513.mail.mud.yahoo.com>
Date: Sun, 15 Jan 2006 09:43:55 -0800 (PST)
From: Jeff Sadowski <jeff_sadowski@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Bridge] setting the hardware address
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

reading through the changelogs for 2.6.15-git11 I
found

    [BRIDGE]: allow setting hardware address of bridge
pseudo-dev
    
    Some people are using bridging to hide multiple
machines from an ISP
    that restricts by MAC address. So in that case
allow the bridge mac
    address to be set to any of the existing
interfaces.  I don't want to
    allow any arbitrary value and confuse STP.

How would an arbitrary value confuse STP?
I think I know what STP(Spanning Tree Protocal) is.
Isn't it what determins which switch to go to next if
a mac isn't found on the local switch?
In which case I might want to change the mac
specifically for this purpose.
I was more wanting to change the mac for the purpose
of it having its own
mac address so it gets a different ip from dhcp. Thats
why I asked the question before. That and for testing
purposes. Changing the mac to an arbitrary value would
be extreamly usefull for testing purposes.

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
