From: Nuutti Kotivuori <naked@iki.fi>
Date: Tue, 01 Feb 2005 14:30:49 +0200
Message-ID: <87y8e8798m.fsf@aka.i.naked.iki.fi>
References: <87pszl99je.fsf@aka.i.naked.iki.fi>
	<20050131084535.10db250a@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@sea.gmane.org>
Subject: [Bridge] Re: Bridge MAC address
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

Stephen Hemminger wrote:
> On Mon, 31 Jan 2005 12:29:09 +0200
> Nuutti Kotivuori <naked@iki.fi> wrote:
>
>> Sorry, if this question has been answered before, but I could not
>> find out with a brief look.
>>
>> How can I set the MAC address for a bridge? The MAC address given
>> for the bridge device seems to be the one it sends network packets
>> with if the bridge device has an IP address set. Apparently the
>> bridge starts with a zero MAC address and when the first interface
>> is attached to it, it takes its MAC address. When I try to set the
>> MAC address, I just get operation unsupported as a result.
>>
>> I know I can probably cheat this by making a dummy interface,
>> giving it the MAC address I want and then attaching it to the
>> bridge, but this is but a crude workaround.
>
> The question is why do you need to set it at all? If this is some
> ISP mac filtering issue, then set it on the first device before
> putting it into the bridge.  I would be reluctant to change the
> bridge driver to accept MAC address changes because of Spanning Tree
> and other standards related issues.

Spanning tree protocol is not used on the bridge devices we are using.

The first devices connected to the bridge are often TAP devices with
random generated MAC addresses (00:FF:xx:xx:xx:xx). Actual ethernet
interfaces are connected and disconnected later on, on the fly. The
MAC address we would like to use for the bridge is allocated from our
private MAC address space, and not bound to any physical interface.

Would it be possible to make the bridge driver accept MAC address
changes *before* any interfaces are connected to it - that is, when it
still has 00:00:00:00:00:00 as MAC address? The issue is not terribly
important, since it can be worked around with the dummy device in any
case.

-- Naked




