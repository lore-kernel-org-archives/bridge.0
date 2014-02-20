Return-Path: <zoltan.kiss@citrix.com>
Message-ID: <5306156B.4070105@citrix.com>
Date: Thu, 20 Feb 2014 14:47:07 +0000
From: Zoltan Kiss <zoltan.kiss@citrix.com>
MIME-Version: 1.0
References: <1392433180-16052-1-git-send-email-mcgrof@do-not-panic.com>
	<1392433180-16052-2-git-send-email-mcgrof@do-not-panic.com>
	<53024C58.4010900@citrix.com>
	<CAB=NE6XYjOd2vRpQCZOG-S5ZW4xjam+FOPAYzribNQpb50Q5pg@mail.gmail.com>
In-Reply-To: <CAB=NE6XYjOd2vRpQCZOG-S5ZW4xjam+FOPAYzribNQpb50Q5pg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [Xen-devel] [RFC v2 1/4] bridge: enable interfaces to
 opt out from becoming the root bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: kvm@vger.kernel.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, xen-devel@lists.xenproject.org

On 19/02/14 16:45, Luis R. Rodriguez wrote:
> On Mon, Feb 17, 2014 at 9:52 AM, Zoltan Kiss <zoltan.kiss@citrix.com> wrote:
>> On 15/02/14 02:59, Luis R. Rodriguez wrote:
>>>
>>> From: "Luis R. Rodriguez" <mcgrof@suse.com>
>>>
>>> It doesn't make sense for some interfaces to become a root bridge
>>> at any point in time. One example is virtual backend interfaces
>>> which rely on other entities on the bridge for actual physical
>>> connectivity. They only provide virtual access.
>>
>> It is possible that a guest bridge together to VIF, either from the same
>> Dom0 bridge or from different ones. In that case using STP on VIFs sound
>> sensible to me.
>
> You seem to describe a case whereby it can make sense for xen-netback
> interfaces to end up becoming the root port of a bridge. Can you
> elaborate a little more on that as it was unclear the use case.
Well, I might be wrong on that, but the scenario I was thinking: a guest 
(let's say domain 1) can have multiple interfaces on different Dom0 (or 
driver domain) bridges, let's say vif1.0 is plugged into xenbr0 and 
vif1.1 is in xenbr1. If the guest wants to make a bridge of this two, 
then using STP makes sense. I wanted to bring up CloudStack's virtual 
router as an example, but then I realized it's probably doesn't do such 
thing. However I don't think we should hardcode that a netback interface 
can't be RP ever.

>
> Additionally if such cases exist then under the current upstream
> implementation one would simply need to change the MAC address in
> order to enable a vif to become the root port.  Stephen noted there is
> a way to avoid nominating an interface for a root port through the
> root block flag. We should use that instead of the MAC address hacks.
> Let's keep in mind that part of the motivation for this series is to
> avoid a duplicate IPv6 address left in place by use cases whereby the
> MAC address of the backend vif was left static. The use case your are
> explaining likely describes the more prevalent use case where address
> conflicts can occur, perhaps when administrators for got to change the
> backend MAC address. If we embrace a random MAC address we'd avoid
> that issue, and but we'd need to update userspace to use the root
> block on topologies where desired.
If I understand you correctly, this is the same I suggested in my 
another email sent 1.5 hour ago.

Zoli

