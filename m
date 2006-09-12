Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 12 Sep 2006 13:46:52 -0700
Message-ID: <C86180A8C204554D8A3323D8F6B0A29F01712470@dhost002-46.dex002.intermedia.net>
From: "Simon Barber" <simon@devicescape.com>
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] RFC: [PATCH] bridge vlan integration
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi Benny,

The bridge patch was developed for a project where we would run on
drivers without hardware acceleration - it does not address hardware
accelerated drivers. In addition there was no requirement to set the
priority field in outgoing frames correctly, so it does not address this
either. Both of these features could be added if someone needed them.

One nice feature of the patch is it allows setting the untagged VLAN on
the bridge interface itself - this allows one to directly configure IP
addresses on that interface, and not require a separate VLAN interface.

I would suggest using the same skb->priority -> VLAN priority mapping
table that the 802.1q code uses. This would enable users of the bridge
interface itself to control the VLAN priority for locally generated
frames.

Simon
 
 
>>>>> "DK" == David Kimdon <david.kimdon at devicescape.com
<https://lists.osdl.org/mailman/listinfo/bridge> > writes:

DK> Hi, The attached patches enables the bridge to filter and forward
DK> packets according to their IEEE 802.1q headers.

How does this work in the presence of hardware VLAN acceleration (as
almost all important cards/drivers offer)? In that case it seems that
the tag is stripped and forgotten about. Does this code somehow avoid
the problem?


/Benny

