Return-Path: <wilco@baanhofman.nl>
Message-ID: <1334183679.3337.14.camel@synlap.andoburg.net>
From: Wilco Baan Hofman <wilco@baanhofman.nl>
Date: Thu, 12 Apr 2012 00:34:39 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
Subject: [Bridge] ebtables on mac80211
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linuxfoundation.org
Cc: linux-wireless@vger.kernel.org

Hi,

I'm looking to implement hooks to ebtables in the mac80211 wireless
stack.

I'm trying to find the best approach for doing this.. basically what I
want to be able to have is clients being able to communicate, but not
ARP spoofing the gateway or setting up a rogue DHCP.

As it's currently implemented, there's some sort of internal bridge
functionality within the wireless stack in net/mac80211/rx.c at around
ieee802_deliver_skb(), where every ethernet packet essentially gets
routed among wireless clients.

If I understand ebtables correctly, an forward event is triggered for
every packet to every interface, right? So essentially, this should do
the same, except that for every wireless client would be a forward from
the wireless interface to the wireless interface.

What would be the best way to implement this and in what way would it be
acceptable upstream?

Best regards,

Wilco Baan Hofman

